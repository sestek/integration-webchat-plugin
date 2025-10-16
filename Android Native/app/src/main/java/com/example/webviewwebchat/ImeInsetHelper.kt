package com.example.webviewwebchat

import android.view.View
import android.view.ViewGroup
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsAnimationCompat
import androidx.core.view.WindowInsetsCompat
import kotlin.math.roundToInt

/**
 * IME (klavye) açıldıkça view'in ALT padding'ine IME yüksekliği uygular.
 * WebView için özellikle gerekli: içerik yukarı itilir.
 */
fun View.applyImeBottomPaddingWithAnimation() {
    val view = this
    var startBottom = view.paddingBottom

    // İnsetleri dinle
    ViewCompat.setOnApplyWindowInsetsListener(view) { v, insets ->
        val imeVisible = insets.isVisible(WindowInsetsCompat.Type.ime())
        val imeHeight = insets.getInsets(WindowInsetsCompat.Type.ime()).bottom

        val targetBottom = if (imeVisible) imeHeight else 0
        v.setPadding(v.paddingLeft, v.paddingTop, v.paddingRight, targetBottom)
        insets
    }

    // Animasyon için
    ViewCompat.setWindowInsetsAnimationCallback(
        view,
        object : WindowInsetsAnimationCompat.Callback(DISPATCH_MODE_CONTINUE_ON_SUBTREE) {
            override fun onPrepare(animation: WindowInsetsAnimationCompat) {
                startBottom = view.paddingBottom
            }

            override fun onProgress(
                insets: WindowInsetsCompat,
                runningAnimations: MutableList<WindowInsetsAnimationCompat>
            ): WindowInsetsCompat {
                val ime = insets.getInsets(WindowInsetsCompat.Type.ime()).bottom
                // runningAnimations içindeki IME animasyonunun ilerleme oranı
                val imeAnim = runningAnimations.firstOrNull {
                    it.typeMask and WindowInsetsCompat.Type.ime() != 0
                }
                val fraction = imeAnim?.interpolatedFraction ?: 1f
                val target = (ime * fraction).roundToInt()

                view.setPadding(view.paddingLeft, view.paddingTop, view.paddingRight, target)
                return insets
            }
        }
    )

    // View padding’i içeriği kesmesin
    if (view is ViewGroup) view.clipToPadding = false
}
