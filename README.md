# «Управляющие конструкции в коде Terraform» - Дрибноход Давид

### Задание 1

1. Изучите проект.
2. Заполните файл personal.auto.tfvars.
3. Инициализируйте проект, выполните код. Он выполнится, даже если доступа к preview нет.

Ответ:

![image](https://github.com/DrDavidN/terhw03/assets/128225763/adb70488-bd20-48cf-9471-c7f9b44161ab)


------

### Задание 2

1. Создайте файл count-vm.tf. Опишите в нём создание двух **одинаковых** ВМ  web-1 и web-2 (не web-0 и web-1) с минимальными параметрами, используя мета-аргумент **count loop**. Назначьте ВМ созданную в первом задании группу безопасности.(как это сделать узнайте в документации провайдера yandex/compute_instance )
2. Создайте файл for_each-vm.tf. Опишите в нём создание двух ВМ для баз данных с именами "main" и "replica" **разных** по cpu/ram/disk , используя мета-аргумент **for_each loop**. Используйте для обеих ВМ одну общую переменную типа:
```
variable "each_vm" {
  type = list(object({  vm_name=string, cpu=number, ram=number, disk=number }))
}
```  
При желании внесите в переменную все возможные параметры.
4. ВМ из пункта 2.1 должны создаваться после создания ВМ из пункта 2.2.
5. Используйте функцию file в local-переменной для считывания ключа ~/.ssh/id_rsa.pub и его последующего использования в блоке metadata, взятому из ДЗ 2.
6. Инициализируйте проект, выполните код.

Ответ:

Листинг count-vm.tf

![image](https://github.com/DrDavidN/terhw03/assets/128225763/2f77cb1b-1f68-4678-a2b4-9e341e5abcc6)


Листинг for_each-vm.tf

![image](https://github.com/DrDavidN/terhw03/assets/128225763/6e6ba5d2-f6f0-4fdd-a699-40c33b1990cf)


Листинг locals.tf

![image](https://github.com/DrDavidN/terhw03/assets/128225763/a3a64eec-b023-4b3d-93fb-443e281ba2f3)


Листинг variables.tf

![image](https://github.com/DrDavidN/terhw03/assets/128225763/97d1dd1e-14aa-4bd8-91ff-5f7694b3c46c)


Скрин созданных ВМ

![image](https://github.com/DrDavidN/terhw03/assets/128225763/36402b6e-2e79-4421-8bb6-04b949a2b1f1)


------

### Задание 3

1. Создайте 3 одинаковых виртуальных диска размером 1 Гб с помощью ресурса yandex_compute_disk и мета-аргумента count в файле **disk_vm.tf** .
2. Создайте в том же файле **одиночную**(использовать count или for_each запрещено из-за задания №4) ВМ c именем "storage"  . Используйте блок **dynamic secondary_disk{..}** и мета-аргумент for_each для подключения созданных вами дополнительных дисков.

Ответ:

Листинг disk_vm.tf

![image](https://github.com/DrDavidN/terhw03/assets/128225763/b9899044-819e-48ce-8ceb-3afa127c632a)


Созданная ВМ с подключенными дисками

![image](https://github.com/DrDavidN/terhw03/assets/128225763/d216539c-3e7b-4f9e-b067-7de74418136a)


------

### Задание 4

1. В файле ansible.tf создайте inventory-файл для ansible.
Используйте функцию tepmplatefile и файл-шаблон для создания ansible inventory-файла из лекции.
Готовый код возьмите из демонстрации к лекции [**demonstration2**](https://github.com/netology-code/ter-homeworks/tree/main/03/demonstration2).
Передайте в него в качестве переменных группы виртуальных машин из задания 2.1, 2.2 и 3.2, т. е. 5 ВМ.
2. Инвентарь должен содержать 3 группы и быть динамическим, т. е. обработать как группу из 2-х ВМ, так и 999 ВМ.
3. Добавьте в инвентарь переменную  [**fqdn**](https://cloud.yandex.ru/docs/compute/concepts/network#hostname).
``` 
[webservers]
web-1 ansible_host=<внешний ip-адрес> fqdn=<полное доменное имя виртуальной машины>
web-2 ansible_host=<внешний ip-адрес> fqdn=<полное доменное имя виртуальной машины>

[databases]
main ansible_host=<внешний ip-адрес> fqdn=<полное доменное имя виртуальной машины>
replica ansible_host<внешний ip-адрес> fqdn=<полное доменное имя виртуальной машины>

[storage]
storage ansible_host=<внешний ip-адрес> fqdn=<полное доменное имя виртуальной машины>
```
Пример fqdn: ```web1.ru-central1.internal```(в случае указания имени ВМ); ```fhm8k1oojmm5lie8i22a.auto.internal```(в случае автоматической генерации имени ВМ зона изменяется). ужную вам переменную найдите в документации провайдера или terraform console.
4. Выполните код. Приложите скриншот получившегося файла. 

Ответ:

Листинг ansible.tf

![image](https://github.com/DrDavidN/terhw03/assets/128225763/ce246118-a28e-4912-ba48-74597015b0b9)

Листинг hosts.tftpl

![image](https://github.com/DrDavidN/terhw03/assets/128225763/77fade1e-83ea-4b35-baae-aead61a69f79)


Получившийся файл

![image](https://github.com/DrDavidN/terhw03/assets/128225763/1322d34d-5271-41db-8560-6ec0dc1c9363)

------

