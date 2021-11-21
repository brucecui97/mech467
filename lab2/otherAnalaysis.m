1/s^2-IntegralController*continousPlant/(1+IntegralController*continousPlant)*1/s^2

b = (IntegralController*continousPlant)/(1+IntegralController*continousPlant)


evalfr(b,0)

s*(1/s^2-(IntegralController*continousPlant)/(1+IntegralController*continousPlant)/s^2)


s*(1/s^2-(continousPlant)/(1+continousPlant)/s^2)


1/s^2-IntegralController*continousPlant/(1+IntegralController*continousPlant)*1/s

evalfr(s*(1/s^2-IntegralController*continousPlant/(1+IntegralController*continousPlant)*1/s^2),0)