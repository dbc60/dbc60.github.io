 # B y   B i g T e d d y   0 5   S e p t e m b e r   2 0 1 1  
  
 # T h i s   s c r i p t   u s e s   t h e   . N E T   F i l e S y s t e m W a t c h e r   c l a s s   t o   m o n i t o r   f i l e   e v e n t s   i n   f o l d e r ( s ) .  
 # T h e   a d v a n t a g e   o f   t h i s   m e t h o d   o v e r   u s i n g   W M I   e v e n t i n g   i s   t h a t   t h i s   c a n   m o n i t o r   s u b - f o l d e r s .  
 # T h e   - A c t i o n   p a r a m e t e r   c a n   c o n t a i n   a n y   v a l i d   P o w e r s h e l l   c o m m a n d s .     I   h a v e   j u s t   i n c l u d e d   t w o   f o r   e x a m p l e .  
 # T h e   s c r i p t   c a n   b e   s e t   t o   a   w i l d c a r d   f i l t e r ,   a n d   I n c l u d e S u b d i r e c t o r i e s   c a n   b e   c h a n g e d   t o   $ t r u e .  
 # Y o u   n e e d   n o t   s u b s c r i b e   t o   a l l   t h r e e   t y p e s   o f   e v e n t .     A l l   t h r e e   a r e   s h o w n   f o r   e x a m p l e .  
 #   V e r s i o n   1 . 1  
  
 $ f o l d e r   =   ' c : \ s c r i p t s \ t e s t '   #   E n t e r   t h e   r o o t   p a t h   y o u   w a n t   t o   m o n i t o r .  
 $ f i l t e r   =   ' * . * '     #   Y o u   c a n   e n t e r   a   w i l d c a r d   f i l t e r   h e r e .  
  
 #   I n   t h e   f o l l o w i n g   l i n e ,   y o u   c a n   c h a n g e   ' I n c l u d e S u b d i r e c t o r i e s   t o   $ t r u e   i f   r e q u i r e d .  
 $ f s w   =   N e w - O b j e c t   I O . F i l e S y s t e m W a t c h e r   $ f o l d e r ,   $ f i l t e r   - P r o p e r t y   @ { I n c l u d e S u b d i r e c t o r i e s   =   $ f a l s e ; N o t i f y F i l t e r   =   [ I O . N o t i f y F i l t e r s ] ' F i l e N a m e ,   L a s t W r i t e ' }  
  
 #   H e r e ,   a l l   t h r e e   e v e n t s   a r e   r e g i s t e r e d .     Y o u   n e e d   o n l y   s u b s c r i b e   t o   e v e n t s   t h a t   y o u   n e e d :  
  
 R e g i s t e r - O b j e c t E v e n t   $ f s w   C r e a t e d   - S o u r c e I d e n t i f i e r   F i l e C r e a t e d   - A c t i o n   {  
 $ n a m e   =   $ E v e n t . S o u r c e E v e n t A r g s . N a m e  
 $ c h a n g e T y p e   =   $ E v e n t . S o u r c e E v e n t A r g s . C h a n g e T y p e  
 $ t i m e S t a m p   =   $ E v e n t . T i m e G e n e r a t e d  
 W r i t e - H o s t   " T h e   f i l e   ' $ n a m e '   w a s   $ c h a n g e T y p e   a t   $ t i m e S t a m p "   - f o r e   g r e e n  
 O u t - F i l e   - F i l e P a t h   c : \ s c r i p t s \ f i l e c h a n g e \ o u t l o g . t x t   - A p p e n d   - I n p u t O b j e c t   " T h e   f i l e   ' $ n a m e '   w a s   $ c h a n g e T y p e   a t   $ t i m e S t a m p " }  
  
 R e g i s t e r - O b j e c t E v e n t   $ f s w   D e l e t e d   - S o u r c e I d e n t i f i e r   F i l e D e l e t e d   - A c t i o n   {  
 $ n a m e   =   $ E v e n t . S o u r c e E v e n t A r g s . N a m e  
 $ c h a n g e T y p e   =   $ E v e n t . S o u r c e E v e n t A r g s . C h a n g e T y p e  
 $ t i m e S t a m p   =   $ E v e n t . T i m e G e n e r a t e d  
 W r i t e - H o s t   " T h e   f i l e   ' $ n a m e '   w a s   $ c h a n g e T y p e   a t   $ t i m e S t a m p "   - f o r e   r e d  
 O u t - F i l e   - F i l e P a t h   c : \ s c r i p t s \ f i l e c h a n g e \ o u t l o g . t x t   - A p p e n d   - I n p u t O b j e c t   " T h e   f i l e   ' $ n a m e '   w a s   $ c h a n g e T y p e   a t   $ t i m e S t a m p " }  
  
 R e g i s t e r - O b j e c t E v e n t   $ f s w   C h a n g e d   - S o u r c e I d e n t i f i e r   F i l e C h a n g e d   - A c t i o n   {  
 $ n a m e   =   $ E v e n t . S o u r c e E v e n t A r g s . N a m e  
 $ c h a n g e T y p e   =   $ E v e n t . S o u r c e E v e n t A r g s . C h a n g e T y p e  
 $ t i m e S t a m p   =   $ E v e n t . T i m e G e n e r a t e d  
 W r i t e - H o s t   " T h e   f i l e   ' $ n a m e '   w a s   $ c h a n g e T y p e   a t   $ t i m e S t a m p "   - f o r e   w h i t e  
 O u t - F i l e   - F i l e P a t h   c : \ s c r i p t s \ f i l e c h a n g e \ o u t l o g . t x t   - A p p e n d   - I n p u t O b j e c t   " T h e   f i l e   ' $ n a m e '   w a s   $ c h a n g e T y p e   a t   $ t i m e S t a m p " }  
  
 #   T o   s t o p   t h e   m o n i t o r i n g ,   r u n   t h e   f o l l o w i n g   c o m m a n d s :  
 #   U n r e g i s t e r - E v e n t   F i l e D e l e t e d  
 #   U n r e g i s t e r - E v e n t   F i l e C r e a t e d  
 #   U n r e g i s t e r - E v e n t   F i l e C h a n g e d  
