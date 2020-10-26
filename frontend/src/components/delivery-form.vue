<template>
  <div>
    <form-tabs
      :active-tab="activeTab"
      @change-tab="changeTab($event)"
    />
    <form @submit.prevent>
      <div v-show="activeTab === 'main'">
        <!-- первый шаг формы -->
        <div
          class="
            xl:grid-cols-4 
            lg:grid-cols-2 lg:gap-x-6
            grid gap-y-4 mb-6
          ">

          <form-input
            v-model="$v.userInfo.firstname.$model"
            :isInvalid="$v.userInfo.firstname.$error"
            placeholder="Иван"
          >
            <template v-slot:label>Имя</template>
            <template v-slot:error>
              <div v-if="!$v.userInfo.firstname.required">Введите Ваше имя.</div>
              <div v-if="!$v.userInfo.firstname.minLength">Минимальная длина {{ pluralizeErrorText($v.userInfo.firstname.$params.minLength.min, 'символ', 'символа', 'символов') }}.</div>
              <div v-if="!$v.userInfo.firstname.maxLength">Максимальная длина {{ pluralizeErrorText($v.userInfo.firstname.$params.maxLength.max, 'символ', 'символа', 'символов') }}.</div>
            </template>
          </form-input>

          <form-input
            v-model="$v.userInfo.lastname.$model"
            :isInvalid="$v.userInfo.lastname.$error"
            placeholder="Иванов"
          >
            <template v-slot:label>Фамилия</template>
            <template v-slot:error>
              <div v-if="!$v.userInfo.lastname.required">Введите Вашу фамилию.</div>
              <div v-if="!$v.userInfo.lastname.minLength">Минимальная длина {{ pluralizeErrorText($v.userInfo.lastname.$params.minLength.min, 'символ', 'символа', 'символов') }}.</div>
              <div v-if="!$v.userInfo.lastname.maxLength">Максимальная длина {{ pluralizeErrorText($v.userInfo.lastname.$params.maxLength.max, 'символ', 'символа', 'символов') }}.</div>
            </template>
          </form-input>

          <form-input
            v-model="$v.userInfo.phone.$model"
            :isInvalid="$v.userInfo.phone.$error"
            placeholder="+79991234567"
          >
            <template v-slot:label>Телефон</template>
            <template v-slot:error>
              <div v-if="!$v.userInfo.phone.required">Введите Ваш номер телефона в формате +7XXXXXXXXXX</div>
              <div v-if="!$v.userInfo.phone.phone">Неверный формат.</div>
            </template>
          </form-input>

          <form-input
            v-model="$v.userInfo.email.$model"
            :isInvalid="$v.userInfo.email.$error"
            placeholder="user@mail.ru"
          >
            <template v-slot:label>Email</template>
            <template v-slot:error>
              <div v-if="!$v.userInfo.email.required">Введите Ваш электронный адрес.</div>
              <div v-if="!$v.userInfo.email.email">Неверный формат.</div>
            </template>
          </form-input>

        </div>
        <button
          class="btn"
          @click="validateFirstStep"
          :disabled="$v.userInfo.$invalid"
        >Продолжить</button>
      </div>
      <div v-show="activeTab === 'address'">
        <!-- второй шаг формы -->
        <div
          class="
            xl:grid-cols-3 
            lg:grid-cols-2 lg:gap-x-6
            grid gap-y-4 mb-6
          "
        >
          <div
            class="
              xl:col-span-3
              lg:col-span-2 lg:order-1
            "
          >
            <label class="flex items-center cursor-pointer">
              <input class="mr-2" type="radio" v-model.number="deliveryInfo.type" value="0">
              <div>Доставка</div>
            </label>
            <label class="flex items-center cursor-pointer">
              <input class="mr-2" type="radio" v-model.number="deliveryInfo.type" value="1">
              <div>Самовывоз</div>
            </label>
          </div>

          <form-input
            class="lg:order-2"
            v-model="$v.deliveryInfo.country.$model"
            :isInvalid="$v.deliveryInfo.country.$error"
            placeholder="Страна"
            v-if="deliveryInfo.type === 0"
          >
            <template v-slot:label>Страна</template>
            <template v-slot:error>
              <div v-if="!$v.deliveryInfo.country.required">Введите страну доставки.</div>
            </template>
          </form-input>

          <form-input
            class="lg:order-3"
            v-model="$v.deliveryInfo.city.$model"
            :isInvalid="$v.deliveryInfo.city.$error"
            placeholder="Город"
            v-if="deliveryInfo.type === 0"
          >
            <template v-slot:label>Город</template>
            <template v-slot:error>
              <div v-if="!$v.deliveryInfo.city.required">Введите город доставки.</div>
            </template>
          </form-input>

          <form-input
            class="
              xl:order-4
              order-5

            "
            v-model="$v.deliveryInfo.zipCode.$model"
            :isInvalid="$v.deliveryInfo.zipCode.$error"
            placeholder="Индекс"
            v-if="deliveryInfo.type === 0"
          >
            <template v-slot:label>Индекс</template>
            <template v-slot:error>
              <div v-if="!$v.deliveryInfo.zipCode.required">Введите индекс доставки.</div>
              <div v-else-if="!$v.deliveryInfo.zipCode.integer || !$v.deliveryInfo.zipCode.exactLength">Индекс состоит из 6 цифр.</div>
            </template>
          </form-input>

          <form-input
            class="
              xl:col-span-3 xl:order-5
              lg:col-span-1 
              order-4
            "
            v-model="$v.deliveryInfo.address.$model"
            :isInvalid="$v.deliveryInfo.address.$error"
            placeholder="Город"
            v-if="deliveryInfo.type === 0"
          >
            <template v-slot:label>Адрес</template>
            <template v-slot:error>
              <div v-if="!$v.deliveryInfo.address.required">Введите адрес доставки.</div>
            </template>
          </form-input>

          <form-input
            class="
              xl:col-span-3
              lg:col-span-2
              col-span-1 order-6
            "
            v-model="$v.deliveryInfo.date.$model"
            :isInvalid="$v.deliveryInfo.date.$error"
            placeholder="Дата доставки"
            v-if="deliveryInfo.type === 0"
          >
            <template v-slot:label>Дата доставки</template>
            <template v-slot:error>
              <div v-if="!$v.deliveryInfo.date.required">Введите дату доставки.</div>
              <div v-if="!$v.deliveryInfo.date.dateFormat">Введите дату в формате дд/мм/гггг</div>
            </template>
          </form-input>

          <form-textarea
            class="
              xl:col-span-3
              lg:col-span-2
              col-span-1 order-7
            "
            v-model="deliveryInfo.comment"
            placeholder="При необходимости, введите дополнительные комментарии..."
          >
            <template v-slot:label>Комментарий к заказу</template>
          </form-textarea>

        </div>
        <div class="flex items-center">
          <button
            class="btn"
            :disabled="($v.deliveryInfo.$invalid && $v.deliveryInfo.$dirty) || loading"
            @click="submitForm"
          >Отправить</button>
          <div class="ml-4" v-if="loading">
            <spinner-animation/>
          </div>
          <div class="ml-4" v-if="requestStatus !== null">
            <div class="text-green-600" v-if="requestStatus === true">Заказ успешно создан!</div>
            <div class="text-red-600" v-if="requestStatus === false">Произошла ошибка :( Попробуйте позже...</div>
          </div>
        </div>
      </div>
    </form>
  </div>
</template>

<script>
import { requiredIf, required, maxLength, minLength, email, integer } from 'vuelidate/lib/validators';

import FormTabs from '@/components/tabs.vue';
import FormInput from '@/components/form-input.vue';
import FormTextarea from '@/components/form-textarea.vue';
import SpinnerAnimation from '@/components/spinner.vue';

/**
 * простая проверка номера телефона
 * символы '+7' и далее 11 цифр
 */
const phoneValidator = (value) => value ? /^\+7\d{10}$/.test(value) : true;

/**
 * Валидация формата даты
 */
const simpleDateValidator = (value) => value ? /^\d{2}\/\d{2}\/\d{4}$/.test(value) : true;

/**
 * Валидация длины ввода
 */
const exactLengthValidator = (length) => (value) => value.length === length;

const initialUserInfo = () => ({
  firstname: '',
  lastname: '',
  phone: '',
  email: '',
});

const initialDeliveryInfo = () => ({
  /**
   * Тип доставки:
   * 0 - доставка курьером
   * 1 - самовывоз
   */
  type: 0,
  country: '',
  city: '',
  zipCode: '',
  address: '',
  date: '',
  comment: '',
})

export default {
  components: {
    FormTabs,
    FormInput,
    FormTextarea,
    SpinnerAnimation,
  },
  data() {
    return {
      activeTab: 'main',
      userInfo: initialUserInfo(),
      deliveryInfo: initialDeliveryInfo(),
      loading: false,
      requestStatus: null,
    };
  },
  validations: {
    userInfo: {
      firstname: {
        required,
        minLength: minLength(4),
        maxLength: maxLength(20),
      },
      lastname: {
        required,
        minLength: minLength(4),
        maxLength: maxLength(10),
      },
      phone: {
        required,
        phone: phoneValidator,
      },
      email: {
        required,
        email,
      }
    },
    deliveryInfo: {
      country: {
        required: requiredIf((deliveryInfo) => deliveryInfo.type === 0),
      },
      city: {
        required: requiredIf((deliveryInfo) => deliveryInfo.type === 0),
      },
      zipCode: {
        required: requiredIf((deliveryInfo) => deliveryInfo.type === 0),
        integer,
        exactLength: exactLengthValidator(6),
      },
      address: {
        required: requiredIf((deliveryInfo) => deliveryInfo.type === 0),
      },
      date: {
        required: requiredIf((deliveryInfo) => deliveryInfo.type === 0),
        dateFormat: simpleDateValidator,
      },
    },
  },
  methods: {
    changeTab(tab) {
      this.$v.$touch();
      if (this.$v.userInfo.$invalid) return;
      this.$v.$reset();
      this.activeTab = tab;
      if (tab === 'main') {
        // обнуляем второй шаг формы
        this.deliveryInfo = Object.assign(this.deliveryInfo, initialDeliveryInfo());
        this.requestStatus = null;
      }
    },
    validateFirstStep() {
      this.changeTab('address');
    },
    async submitForm() {
      this.$v.$touch();
      if (this.$v.userInfo.$invalid) return;
      
      this.loading = true;
      const response = await fetch('/api/test.php', {
        method: 'POST',
        body: JSON.stringify({
          ...this.userInfo,
          ...this.deliveryInfo,
        }),
        headers: {
          'Content-Type': 'application/json',
        },
      });
      const json = await response.json();
      this.requestStatus = json.success;
      this.loading = false;
    },
    pluralizeErrorText(number, one, two, five) {
      return `${number} ${this.getNoun(number, one, two, five)}`;
    },
    getNoun(number, one, two, five) {
      let n = Math.abs(number);
      n %= 100;
      if (n >= 5 && n <= 20) return five;
      n %= 10;
      if (n === 1) return one;
      if (n >= 2 && n <= 4) return two;
      return five;
    }
  },
};
</script>

<style lang="postcss" scoped>
.btn {
  @apply bg-blue-400 text-white py-2 px-4 rounded border border-blue-400;
  @apply transition duration-200;
}
.btn:disabled {
  @apply cursor-not-allowed;
  filter: grayscale(1);
}
.btn:hover {
  @apply bg-blue-600 bg-blue-600;
}
.btn:focus {
  @apply outline-none border-blue-900;
}

</style>