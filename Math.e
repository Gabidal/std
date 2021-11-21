static std{
    double Pi = 3.14159265358979323846;
    double E = 2.71828182845904523536;
    double Eps = 1e-6;
    double Inf = 1e20;
    double Nan = Inf - Inf;

    T Gcd<T>(T a, T b) {
        if (a < 0){ 
            return Gcd(-a, b);
        }
        if (b < 0){ 
            return Gcd(a, -b);
        }
        if (b == 0){
            return a;
        }
        return Gcd(b, a % b);
    }

    T Lcm<T>(T a, T b) {
        if (a < 0){ 
            return Lcm(-a, b);
        }
        if (b < 0){ 
            return Lcm(a, -b);
        }
        if (a == 0 || b == 0){
            return 0;
        }
        return a / Gcd(a, b) * b;
    }


    T Power<T>(T a, int n) {
        if (n == 0){
            return 1;
        }
        if (n == 1){
            return a;
        }
        if (n % 2 == 0){
            return Power(a * a, n / 2);
        }
        return a * Power(a * a, n / 2);
    }

    T Power<T>(T a, T n, T mod) {
        if (n == 0){
            return 1;
        }
        if (n == 1){
            return a;
        }
        if (n % 2 == 0){
            return Power(a * a % mod, n / 2, mod) % mod;
        }
        return a * Power(a * a % mod, n / 2, mod) % mod;
    }

    T Inv<T>(T a, T mod) {
        return Power(a, mod - 2, mod);
    }

    T Cnt<T>(T a, T mod) {
        return Inv(Power(a, mod - 2), mod);
    }

    T Sqrt<T>(T a, T mod) {
        return Power(a, (mod - 1) / 2, mod);
    }

    T Sqrt<T>(T a) {
        return Sqrt(a, (T)1e9 + 7);
    }

    T Binpow<T>(T a, T n) {
        if (n == 0){
            return 1;
        }
        if (n == 1){
            return a;
        }
        if (n % 2 == 0){
            return Binpow(a * a, n / 2);
        }
        return a * Binpow(a * a, n / 2);
    }

    T Binpow<T>(T a, T n, T mod) {
        if (n == 0){
            return 1;
        }
        if (n == 1){
            return a;
        }
        if (n % 2 == 0){
            return Binpow(a * a % mod, n / 2, mod) % mod;
        }
        return a * Binpow(a * a % mod, n / 2, mod) % mod;
    }

    T Fac<T>(T n) {
        if (n < 0){
            return Inf;
        }
        if (n == 0){
            return 1;
        }
        return n * Fac<T>(n - 1);
    }

    T Fac<T>(T n, T mod) {
        if (n < 0){
            return Inf;
        }
        if (n == 0){
            return 1;
        }
        return (n % mod) * Fac<T>(n - 1, mod) % mod;
    }

    T Cnt<T>(T n) {
        if (n < 0){
            return Inf;
        }
        if (n == 0){
            return 0;
        }
        return n + Cnt<T>(n - 1);
    }

    T Cnt<T>(T n, T mod) {
        if (n < 0){
            return Inf;
        }
        if (n == 0){
            return 0;
        }
        return (n % mod + Cnt<T>(n - 1, mod)) % mod;
    }

    T Max<T>(T a, T b){
        if (a < b){
            return b;
        }
        return a;
    }

    T Min<T>(T a, T b){
        if (a > b){
            return b;
        }
        return a;
    }

    T Abs<T>(T a){
        if (a > 0){
            return a;
        }
        return -a;
    }

    T Sign<T>(T a){
        if (a > 0){
            return 1;
        }
        if (a < 0){
            return -1;
        }
        return 0;
    }

    T Ceil<T>(T a, T b){
        if (a % b == 0){
            return a / b;
        }
        return (a / b) + 1;
    }

    T Floor<T>(T a, T b){
        if (a % b == 0){
            return a / b;
        }
        return (a / b);
    }
}