# Flutter Uygulama Projesi

Bu proje, Riverpod kullanılarak MVC/MVC+S mimarisi kullanılarak geliştirilmiş bir Flutter uygulamasını içermektedir. Ayrıca, https://reqres.in/ API'sini kullanarak katılımcıları listeleyen bir sayfaya erişim sağlamaktadır.

## Özellikler

1. **MVC/MVC+S Mimarisi:** Uygulama, Riverpod ile birlikte MVC/MVC+S mimarisi kullanılarak geliştirilmiştir. Bu, kodun düzenli ve sürdürülebilir olmasını sağlar.

2. **Giriş Bilgisi Doğrulama:** Kullanıcıdan alınan e-posta ve şifre bilgileri, doğru bir şekilde doğrulanmalıdır. Eksik veya hatalı giriş bilgileri durumunda, kullanıcıya uygun hata mesajları gösterilmelidir.

3. **Login İstekleri:** Giriş yapılırken, `https://reqres.in/` adresine `dio` ile  bir istek gönderilmektedir. Başarılı bir giriş durumunda, gelen token hem `SharedPreferences` kullanılarak yerel depolamaya kaydedilmekte hem de `Riverpod` kullanılarak uygulama boyunca erişilebilir hale getirilmektedir.

4. **Katılımcılar Sayfası:** Kullanıcı başarılı bir şekilde giriş yaptığında, katılımcıların listesi `https://reqres.in/` API'sini kullanarak çekilmektedir. Bu katılımcılar verisi, bir state yöneticisi olan Riverpod kullanılarak saklanmaktadır.

5. **Otomatik Giriş:** Uygulama açıldığında, kullanıcı daha önce giriş yapmışsa otomatik olarak giriş yapılacaktır. Bu, uygulama açıldığında yerel depolamadan token kontrolü ile sağlanmaktadır.

6. **Route İşlemleri:** Uygulama içindeki sayfa geçişleri ve yönlendirmeler `go_router` kütüphanesi kullanılarak gerçekleştirilmektedir. Bu sayede uygulama içi navigasyonlar daha etkili ve yönetilebilir hale gelmiştir.

## Nasıl Çalıştırılır?

1. Projeyi klonlayın: `git clone https://github.com/EmrSyhn/voco_app.git`
2. Proje dizinine gidin: `cd ../voco_app`
3. Gerekli bağımlılıkları yükleyin: `flutter pub get`
4. Uygulamayı çalıştırın: `flutter run`

## Katkıda Bulunma

Eğer projeye katkıda bulunmak istiyorsanız, lütfen forklayın ve bir pull request gönderin.
