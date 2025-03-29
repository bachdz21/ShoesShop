(function ($) {
    "use strict";
    // Các phần còn lại của mã (Slick, Product img zoom, v.v.) giữ nguyên
    // Mobile Nav toggle
    $('.menu-toggle > a').on('click', function (e) {
        e.preventDefault();
        $('#responsive-nav').toggleClass('active');
    });

    // Fix cart dropdown from closing
    $('.cart-dropdown').on('click', function (e) {
        e.stopPropagation();
    });

    // Products Slick
    $('.products-slick').each(function () {
        var $this = $(this),
                $nav = $this.attr('data-nav');

        $this.slick({
            slidesToShow: 4,
            slidesToScroll: 1,
            autoplay: true,
            infinite: true,
            speed: 300,
            dots: false,
            arrows: true,
            appendArrows: $nav ? $nav : false,
            responsive: [{
                    breakpoint: 991,
                    settings: {
                        slidesToShow: 2,
                        slidesToScroll: 1,
                    }
                },
                {
                    breakpoint: 480,
                    settings: {
                        slidesToShow: 1,
                        slidesToScroll: 1,
                    }
                },
            ]
        });
    });

    // Products Widget Slick
    $('.products-widget-slick').each(function () {
        var $this = $(this),
                $nav = $this.attr('data-nav');

        $this.slick({
            infinite: true,
            autoplay: true,
            speed: 300,
            dots: false,
            arrows: true,
            appendArrows: $nav ? $nav : false,
        });
    });

    // Product Main img Slick
    $('#product-main-img').slick({
        infinite: true,
        speed: 300,
        dots: false,
        arrows: true,
        fade: true,
        asNavFor: '#product-imgs',
    });

    // Product imgs Slick
    $('#product-imgs').slick({
        slidesToShow: 3,
        slidesToScroll: 1,
        arrows: true,
        centerMode: true,
        focusOnSelect: true,
        centerPadding: 0,
        vertical: true,
        asNavFor: '#product-main-img',
        responsive: [{
                breakpoint: 991,
                settings: {
                    vertical: false,
                    arrows: false,
                    dots: true,
                }
            },
        ]
    });

    // Product img zoom
    var zoomMainProduct = document.getElementById('product-main-img');
    if (zoomMainProduct) {
        $('#product-main-img .product-preview').zoom({
            magnify: 2 // Thay đổi giá trị ở đây
        });
    }
    // Hàm định dạng số với dấu phân cách hàng nghìn
    function formatPrice(value) {
        return parseInt(value).toLocaleString('vi-VN');
    }

    // Hàm loại bỏ định dạng để lấy giá trị số nguyên
    function parsePrice(text) {
        // Loại bỏ tất cả ký tự không phải số (ví dụ: dấu phẩy, "VNĐ")
        return parseInt(text.replace(/[^0-9]/g, '')) || 0;
    }

    // Hàm bảo toàn vị trí con trỏ
    function setCaretPosition(element, caretPos) {
        const range = document.createRange();
        const sel = window.getSelection();
        let currentNode = element.childNodes[0] || element;
        let offset = caretPos;

        if (currentNode.nodeType === Node.TEXT_NODE) {
            if (offset > currentNode.length) {
                offset = currentNode.length;
            }
            range.setStart(currentNode, offset);
            range.collapse(true);
            sel.removeAllRanges();
            sel.addRange(range);
        }
    }

    // Hàm lấy vị trí con trỏ hiện tại
    function getCaretPosition(element) {
        let caretPos = 0;
        const sel = window.getSelection();
        if (sel.rangeCount > 0) {
            const range = sel.getRangeAt(0);
            const preCaretRange = range.cloneRange();
            preCaretRange.selectNodeContents(element);
            preCaretRange.setEnd(range.endContainer, range.endOffset);
            caretPos = preCaretRange.toString().length;
        }
        return caretPos;
    }

    // Input number
    $('.input-number').each(function () {
        var $this = $(this),
                $input = $this.find('input[type="number"]'),
                $display = $this.find('.price-display'),
                up = $this.find('.qty-up'),
                down = $this.find('.qty-down');

        // Cập nhật hiển thị ban đầu
        $display.text(formatPrice($input.val() || 0));

        // Xóa nội dung khi người dùng bắt đầu nhập
        $display.on('focus', function () {
            let rawValue = parsePrice($(this).text());
            $(this).text(rawValue); // Hiển thị số thô khi bắt đầu nhập
        });

        // Chỉ cho phép nhập số
        $display.on('keypress', function (e) {
            if (!/[0-9]/.test(e.key)) {
                e.preventDefault(); // Chỉ cho phép nhập số
            }
        });

        // Định dạng ngay trong lúc nhập
        $display.on('input', function () {
            let rawText = $(this).text();
            let rawValue = parsePrice(rawText); // Lấy giá trị số nguyên
            if (rawValue < 1)
                rawValue = 1; // Giới hạn giá trị tối thiểu là 1
            if (rawValue > 9999999)
                rawValue = 9999999; // Giới hạn giá trị tối đa

            // Lấy vị trí con trỏ trước khi định dạng
            let caretPos = getCaretPosition(this);
            let originalLength = rawText.length;

            // Định dạng lại giá trị
            let formattedValue = formatPrice(rawValue);
            $(this).text(formattedValue);

            // Tính toán vị trí con trỏ mới
            let newLength = formattedValue.length;
            let diff = newLength - originalLength;
            let newCaretPos = caretPos + diff;

            // Đặt lại vị trí con trỏ
            setCaretPosition(this, newCaretPos);

            // Cập nhật input ẩn và thanh kéo
            $input.val(rawValue);
            updatePriceSlider($this, rawValue);
        });

        // Xử lý khi người dùng nhấn Enter
        $display.on('keypress', function (e) {
            if (e.key === 'Enter') {
                e.preventDefault(); // Ngăn hành vi mặc định của Enter
                let rawValue = parsePrice($(this).text()); // Lấy giá trị số nguyên
                if (rawValue < 1)
                    rawValue = 1; // Giới hạn giá trị tối thiểu là 1
                if (rawValue > 9999999)
                    rawValue = 9999999; // Giới hạn giá trị tối đa
                $input.val(rawValue); // Cập nhật input ẩn
                $(this).text(formatPrice(rawValue)); // Định dạng lại hiển thị
                updatePriceSlider($this, rawValue); // Cập nhật thanh kéo
            }
        });

        // Xử lý khi người dùng rời khỏi ô nhập
        $display.on('blur', function () {
            let rawValue = parsePrice($(this).text());
            if (rawValue < 1)
                rawValue = 1; // Giới hạn giá trị tối thiểu
            if (rawValue > 9999999)
                rawValue = 9999999; // Giới hạn giá trị tối đa
            $input.val(rawValue);
            $(this).text(formatPrice(rawValue));
            updatePriceSlider($this, rawValue);
        });

        down.on('click', function () {
            let value = parseInt($input.val()) - 1;
            value = value < 1 ? 1 : value; // Giới hạn giá trị tối thiểu là 1
            $input.val(value);
            $display.text(formatPrice(value)); // Cập nhật hiển thị
            $input.change();
            updatePriceSlider($this, value);
        });

        up.on('click', function () {
            let value = parseInt($input.val()) + 1;
            $input.val(value);
            $display.text(formatPrice(value)); // Cập nhật hiển thị
            $input.change();
            updatePriceSlider($this, value);
        });
    });

    var priceInputMax = document.getElementById('price-max'),
            priceInputMin = document.getElementById('price-min'),
            priceDisplayMax = document.getElementById('price-max-display'),
            priceDisplayMin = document.getElementById('price-min-display');

    // Cập nhật từ input khi người dùng nhập tay (nếu cần)
    priceInputMax.addEventListener('change', function () {
        updatePriceSlider($(this).parent(), this.value);
        priceDisplayMax.textContent = formatPrice(this.value);
    });

    priceInputMin.addEventListener('change', function () {
        updatePriceSlider($(this).parent(), this.value);
        priceDisplayMin.textContent = formatPrice(this.value);
    });

    function updatePriceSlider(elem, value) {
        if (elem.hasClass('price-min')) {
            priceSlider.noUiSlider.set([value, null]);
        } else if (elem.hasClass('price-max')) {
            priceSlider.noUiSlider.set([null, value]);
        }
    }

    // Price Slider
    var priceSlider = document.getElementById('price-slider');
    if (priceSlider) {
        noUiSlider.create(priceSlider, {
            start: [1, 9999999], // Giá trị khởi tạo
            connect: true,
            step: 1,
            range: {
                'min': 1,
                'max': 9999999
            }
        });

        priceSlider.noUiSlider.on('update', function (values, handle) {
            var value = Math.round(values[handle]); // Làm tròn số
            if (handle) {
                priceInputMax.value = value; // Cập nhật giá trị input ẩn
                priceDisplayMax.textContent = formatPrice(value); // Cập nhật hiển thị
            } else {
                priceInputMin.value = value; // Cập nhật giá trị input ẩn
                priceDisplayMin.textContent = formatPrice(value); // Cập nhật hiển thị
            }
        });
    }


})(jQuery);