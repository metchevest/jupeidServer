defmodule Juserver.Sample_Data do
  alias Juserver.{Activities, Groups, Payments}

  def create_test_data(user) do
    group_1 = Groups.create_user_group(%{name: "Group Test 1", cost: 2500.00, user: user})
    group_2 = Groups.create_user_group(%{name: "Group Test 2", cost: 2800.00, user: user})
    group_3 = Groups.create_user_group(%{name: "Group Test 3", cost: 2950.00, user: user})
    group_4 = Groups.create_user_group(%{name: "Group Test 4", cost: 2600.00, user: user})

    class_1 =
      Activities.create_user_class(%{
        name: "Yoga Test",
        hour: 19.00,
        date: "monday",
        activity: "yoga",
        user: user
      })

    class_2 =
      Activities.create_user_class(%{
        name: "English Test",
        hour: 14.00,
        date: "Wednesday",
        activity: "Learn English",
        user: user
      })

    class_3 =
      Activities.create_user_class(%{
        name: "Yoga Artistic Test",
        hour: 15.00,
        date: "thursday",
        activity: "Yoga Artistic",
        user: user
      })

    class_4 =
      Activities.create_user_class(%{
        name: "Yoga Test",
        hour: 17.00,
        date: "Friday",
        activity: "yoga",
        user: user
      })

    student_1 =
      Groups.create_user_student(%{name: "Tony Test", email: "the_tony@gmail.com", user: user})

    student_2 =
      Groups.create_user_student(%{name: "Bradd Test", email: "bradd@gmail.com", user: user})

    student_3 =
      Groups.create_user_student(%{name: "Yolanda Test", email: "yolanda@gmail.com", user: user})

    student_4 =
      Groups.create_user_student(%{name: "Ariadna Test", email: "ariadna@gmail.com", user: user})

    # Payments.create_user_payment(%{student_id: student_1.id, month: 1, year: 2021}, user)
    # Payments.create_user_payment(%{student_id: student_2.id, month: 1, year: 2021}, user)
    # Payments.create_user_payment(%{student_id: student_3.id, month: 1, year: 2021}, user)
    # Payments.create_user_payment(%{student_id: student_4.id, month: 1, year: 2021}, user)

    Groups.add_many_students_to_group(group_1, [student_1, student_3])
    Groups.add_many_students_to_group(group_2, [student_2, student_4])
    Groups.add_many_students_to_group(group_3, [student_1, student_4])
    Groups.add_many_students_to_group(group_4, [student_1, student_2])

    Activities.add_many_students_to_class(class_1, [student_1, student_3])
    Activities.add_many_students_to_class(class_2, [student_2, student_4])
    Activities.add_many_students_to_class(class_3, [student_1, student_4])
    Activities.add_many_students_to_class(class_4, [student_1, student_2])
  end
end
