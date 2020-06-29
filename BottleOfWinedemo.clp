
;;;======================================================
;;;   BottleOfWine Expert System
;;;
;;;     This expert system will help you
;;;     find the perfect bottle of wine.
;;;
;;;     CLIPS Version 6.3 Example
;;;
;;;     For use with the Wine Demo Example
;;;======================================================

;;; ***************************
;;; * DEFTEMPLATES & DEFFACTS *
;;; ***************************

(deftemplate UI-state
   (slot id (default-dynamic (gensym*)))
   (slot display)
   (slot relation-asserted (default none))
   (slot response (default none))
   (multislot valid-answers)
   (slot state (default middle)))

(deftemplate state-list
   (slot current)
   (multislot sequence))

(deffacts startup
   (state-list))

;;;****************
;;;* STARTUP RULE *
;;;****************

(defrule system-banner ""

  =>

  (assert (UI-state (display WelcomeMessage)
                    (relation-asserted start)
                    (state initial)
                    (valid-answers))))

;;;***************
;;;* QUERY RULES *
;;;***************

(defrule WhoDrinking ""

   (logical (start))

   =>

   (assert (UI-state (display WhoDrinking)
                     (relation-asserted WhoDrinking)
                     (response SomeoneElse)
                     (valid-answers SomeoneElse PersonalUse))))

(defrule GatheringQuestion ""

   (logical (WhoDrinking SomeoneElse))

   =>

   (assert (UI-state (display GatheringQuestion)
                     (relation-asserted Gathering)
                     (response No)
                     (valid-answers No Yes))))

(defrule AtHomeQuestion ""

   (logical (WhoDrinking PersonalUse))

   =>

   (assert (UI-state (display AtHomeQuestion)
                     (relation-asserted AtHome)
                     (response No)
                     (valid-answers No Yes))))

(defrule GiftQuestion ""

   (logical (Gathering No))

   =>

   (assert (UI-state (display GiftQuestion)
                     (relation-asserted Gift)
                     (response Yes)
                     (valid-answers Yes))))

(defrule WineLoverQuestion ""

   (or
     (logical (Gift Yes))
     (logical (KnowThem Yes))
     )

   =>

   (assert (UI-state (display WineLoverQuestion)
                     (relation-asserted WineLover)
                     (response No)
                     (valid-answers No Yes))))

(defrule PickOneQuestion ""

   (logical (Gathering Yes))

   =>

   (assert (UI-state (display PickOneQuestion)
                     (relation-asserted PickOne)
                     (response GetTogether)
                     (valid-answers GetTogether Bachelor DinnerParty BeachBBQ ArtOpening))))

(defrule WhoIsCookingQuestion ""

   (logical (PickOne DinnerParty))

   =>

   (assert (UI-state (display WhoIsCookingQuestion)
                     (relation-asserted WhoIsCooking)
                     (response Them)
                     (valid-answers Them Me))))

(defrule KnowThemQuestion ""

   (logical (PickOne GetTogether))

   =>

   (assert (UI-state (display KnowThemQuestion)
                     (relation-asserted KnowThem)
                     (response No)
                     (valid-answers No Yes))))

(defrule YourFavoritePeopleQuestion ""

  (or
    (logical (KnowThem Yes)
    (PickOne GetTogether))
    (logical (ReallyKnowThem Yes)
    )
  )

   =>

   (assert (UI-state (display YourFavoritePeopleQuestion)
                     (relation-asserted YourFavoritePeople)
                     (response No)
                     (valid-answers No Yes))))

(defrule BeHonestQuestion ""

    (logical (YourFavoritePeople Yes))

   =>

   (assert (UI-state (display BeHonestQuestion)
                     (relation-asserted BeHonest)
                     (response Yes)
                     (valid-answers Yes))))

(defrule ReallyKnowThemQuestion ""

    (logical (WineLover Yes)
             (Gathering No)
    )

   =>

   (assert (UI-state (display ReallyKnowThemQuestion)
                     (relation-asserted ReallyKnowThem)
                     (response No)
                     (valid-answers No Yes))))

(defrule OnTheGoQuestion ""

   (logical (AtHome No))

   =>

   (assert (UI-state (display OnTheGoQuestion)
                     (relation-asserted OnTheGo)
                     (response Dinner)
                     (valid-answers Dinner Restaurant Camping DrinkingInPublic Special))))

(defrule AloneQuestion ""

    (or
      (logical (AtHome Yes))
      (logical (Special NewYears))
    )

   =>

   (assert (UI-state (display AloneQuestion)
                     (relation-asserted Alone)
                     (response No)
                     (valid-answers No Yes))))

(defrule WineMainCourseQuestion ""

    (or
    (logical (OnTheGo Dinner))
    (and
      (logical (Alone No))
      (logical (AtHome Yes))
    )
    )

   =>

   (assert (UI-state (display WineMainCourseQuestion)
                     (relation-asserted WineMainCourse)
                     (response No)
                     (valid-answers No Yes))))

(defrule SpecialQuestion ""

   (logical (OnTheGo Special))

   =>

   (assert (UI-state (display SpecialQuestion)
                     (relation-asserted Special)
                     (response Anniversary)
                     (valid-answers Anniversary Eloping Birthday BlindDate NewYears))))

(defrule AnniversaryQuestion ""

    (logical (Special Anniversary))

   =>

   (assert (UI-state (display AnniversaryQuestion)
                     (relation-asserted Anniversary)
                     (response First)
                     (valid-answers First Higher))))

(defrule OldQuestion ""

    (logical (Special Birthday))

   =>

   (assert (UI-state (display OldQuestion)
                     (relation-asserted Old)
                     (response No)
                     (valid-answers No Yes))))

(defrule FancyQuestion ""

    (logical (OnTheGo Restaurant))

   =>

   (assert (UI-state (display FancyQuestion)
                     (relation-asserted Fancy)
                     (response No)
                     (valid-answers No Yes))))

(defrule PronounceMenuQuestion ""

    (logical (Fancy Yes))

   =>

   (assert (UI-state (display PronounceMenuQuestion)
                     (relation-asserted PronounceMenu)
                     (response No)
                     (valid-answers No Yes))))

(defrule NewVsOldQuestion ""

    (or
      (logical (PronounceMenu Yes))
      (logical (Collection Yes))
    )
   =>

   (assert (UI-state (display NewVsOldQuestion)
                     (relation-asserted NewVsOld)
                     (response Old)
                     (valid-answers Old New What))))

(defrule IntoCultsQuestion ""

    (logical (NewVsOld New))

   =>

   (assert (UI-state (display IntoCultsQuestion)
                     (relation-asserted IntoCults)
                     (response No)
                     (valid-answers No Yes))))

(defrule OrderWindowQuestion ""

    (logical (Fancy No))

   =>

   (assert (UI-state (display OrderWindowQuestion)
                     (relation-asserted OrderWindow)
                     (response No)
                     (valid-answers No Yes))))

(defrule MicrowaveDinnerQuestion ""

    (logical (WineMainCourse No))

   =>

   (assert (UI-state (display MicrowaveDinnerQuestion)
                     (relation-asserted MicrowaveDinner)
                     (response No)
                     (valid-answers No Yes))))

(defrule CookingWithWineQuestion ""

    (logical (MicrowaveDinner No))

   =>

   (assert (UI-state (display CookingWithWineQuestion)
                     (relation-asserted CookingWithWine)
                     (response No)
                     (valid-answers No Yes))))

(defrule Kool-aidManQuestion ""

    (or
      (logical (CookingWithWine No))
      (logical (DailyDrinking Yes))
    )

   =>

   (assert (UI-state (display Kool-aidManQuestion)
                     (relation-asserted Kool-aidMan)
                     (response No)
                     (valid-answers No Yes))))

(defrule EatDirtQuestion ""

    (logical (Kool-aidMan No))

   =>

   (assert (UI-state (display EatDirtQuestion)
                     (relation-asserted EatDirt)
                     (response No)
                     (valid-answers No Yum))))

(defrule SprayButterQuestion ""

    (logical (Kool-aidMan No))

   =>

   (assert (UI-state (display SprayButterQuestion)
                     (relation-asserted SprayButter)
                     (response No!)
                     (valid-answers No! Yep))))

(defrule RecoveringQuestion ""

    (and
      (logical (Alone Yes))
      (logical (AtHome Yes))
    )

   =>

   (assert (UI-state (display RecoveringQuestion)
                     (relation-asserted Recovering)
                     (response No)
                     (valid-answers No Yes))))

(defrule DrunkQuestion ""

    (logical (Recovering No))

   =>

   (assert (UI-state (display DrunkQuestion)
                     (relation-asserted Drunk)
                     (response No)
                     (valid-answers No Yes))))

(defrule FeelingFancyQuestion ""

    (logical (Drunk No))

   =>

   (assert (UI-state (display FeelingFancyQuestion)
                     (relation-asserted FeelingFancy)
                     (response No)
                     (valid-answers No Oui))))

(defrule DailyDrinkingQuestion ""

    (logical (FeelingFancy No))

   =>

   (assert (UI-state (display DailyDrinkingQuestion)
                     (relation-asserted DailyDrinking)
                     (response No)
                     (valid-answers No Yes))))

(defrule CollectionQuestion ""

    (logical (DailyDrinking No))

   =>

   (assert (UI-state (display CollectionQuestion)
                     (relation-asserted Collection)
                     (response Yes)
                     (valid-answers Yes))))

;;;****************
;;;* REPAIR RULES *
;;;****************

(defrule DontDeserveFinal-Conclusions ""

   (or
     (logical (WineLover No))
     (logical (WhoIsCooking Me))
     (logical (ReallyKnowThem No))
     (logical (YourFavoritePeople No))
     )

   =>

   (assert (UI-state (display DontDeserveFinal)
                     (state final))))

(defrule PickOne-ArtOpening-Conclusions ""

   (logical (PickOne ArtOpening))

   =>

   (assert (UI-state (display ArtOpeningFinal)
                     (state final))))

(defrule PickOne-BeachBBQ-Conclusions ""

   (logical (PickOne BeachBBQ))

   =>

   (assert (UI-state (display BeachBBQFinal)
                     (state final))))

(defrule PickOne-Bachelor-Conclusions ""

   (logical (PickOne Bachelor))

   =>

   (assert (UI-state (display BachelorFinal)
                     (state final))))

(defrule WhoIsCooking-Them-Conclusions ""

   (logical (WhoIsCooking Them))

   =>

   (assert (UI-state (display RedBlendFinal)
                     (state final))))

(defrule KnowThem-No-Conclusions ""

   (logical (KnowThem No))

   =>

   (assert (UI-state (display BoringBottelFinal)
                     (state final))))

(defrule CaliforniaPinotNoirFinal-Conclusions ""

    (or
    (logical (BeHonest Yes))
    (logical (Anniversary First))
    (logical (Old Yes))
    )

   =>

   (assert (UI-state (display CaliforniaPinotNoirFinal)
                     (state final))))

(defrule Anniversary-Higher-Conclusions ""

   (logical (Anniversary Higher))

   =>

   (assert (UI-state (display MerlotFinal)
                     (state final))))

(defrule RieslingFinal-Conclusions ""

    (or
    (logical (Special Eloping))
    (logical (Old No))
    (logical (Special BlindDate))
    )

   =>

   (assert (UI-state (display RieslingFinal)
                     (state final))))

(defrule Alone-No-Conclusions ""

    (or
      (and
      (logical (Alone No))
      (logical (Special NewYears))
      )
      (logical (FeelingFancy Oui))
      (logical (WineMainCourse Yes))
    )

   =>

   (assert (UI-state (display SangioveseFinal)
                     (state final))))

(defrule Alone-Yes-Conclusions ""

   (and
   (logical (Alone Yes))
   (logical (Special NewYears))
   )
   =>

   (assert (UI-state (display CavaFinal)
                     (state final))))

(defrule BoxWineFinal-Conclusions ""

    (or
    (logical (OnTheGo DrinkingInPublic))
    (logical (OnTheGo Camping))
    )

   =>

   (assert (UI-state (display BoxWineFinal)
                     (state final))))

(defrule PronounceMenu-No-Conclusions ""

   (logical (PronounceMenu No))

   =>

   (assert (UI-state (display CotesDuRhoneFinal)
                     (state final))))

(defrule IntoCults-Yes-Conclusions ""

   (logical (IntoCults Yes))

   =>

   (assert (UI-state (display CayuseFinal)
                     (state final))))

(defrule CaliforniaCabernetFinal-Conclusions ""

    (or
    (logical (IntoCults No))
    (logical (OrderWindow No))
    )

   =>

   (assert (UI-state (display CaliforniaCabernetFinal)
                     (state final))))

(defrule NewVsOld-Old-Conclusions ""

   (logical (NewVsOld Old))

   =>

   (assert (UI-state (display BordeauxFinal)
                     (state final))))

(defrule ThxForPlain-Conclusions ""

  (or
   (logical (NewVsOld What))
   (logical (SprayButter No!))
   )

   =>

   (assert (UI-state (display ThxForPlainFinal)
                     (state final))))

(defrule Box3literFinal-Conclusions ""

    (or
    (logical (MicrowaveDinner Yes))
    (logical (OrderWindow Yes))
    )

   =>

   (assert (UI-state (display Box3literFinal)
                     (state final))))

(defrule SprayButter-Yep-Conclusions ""

   (logical (SprayButter Yep))

   =>

   (assert (UI-state (display ButterChardoneFinal)
                     (state final))))

(defrule EatDirt-Yum-Conclusions ""

   (logical (EatDirt Yum))

   =>

   (assert (UI-state (display ChinonFinal)
                     (state final))))

(defrule Kool-aidMan-Yes-Conclusions ""

   (logical (Kool-aidMan Yes))

   =>

   (assert (UI-state (display MalbecFinal)
                     (state final))))

(defrule CookingWithWine-Yes-Conclusions ""

   (logical (CookingWithWine Yes))

   =>

   (assert (UI-state (display SauvignonBlancFinal)
                     (state final))))

(defrule Recovering-Yes-Conclusions ""

   (logical (Recovering Yes))

   =>

   (assert (UI-state (display PinotNoirFinal)
                     (state final))))

(defrule Drunk-Yes-Conclusions ""

   (logical (Drunk Yes))

   =>

   (assert (UI-state (display ShirazFinal)
                     (state final))))

(defrule no-repairs ""

   (declare (salience -10))

   (logical (UI-state (id ?id)))

   (state-list (current ?id))

   =>

   (assert (UI-state (display DupaFinal)
                     (state final))))

;;;*************************
;;;* GUI INTERACTION RULES *
;;;*************************

(defrule ask-question

   (declare (salience 5))

   (UI-state (id ?id))

   ?f <- (state-list (sequence $?s&:(not (member$ ?id ?s))))

   =>

   (modify ?f (current ?id)
              (sequence ?id ?s))

   (halt))

(defrule handle-next-no-change-none-middle-of-chain

   (declare (salience 10))

   ?f1 <- (next ?id)

   ?f2 <- (state-list (current ?id) (sequence $? ?nid ?id $?))

   =>

   (retract ?f1)

   (modify ?f2 (current ?nid))

   (halt))

(defrule handle-next-response-none-end-of-chain

   (declare (salience 10))

   ?f <- (next ?id)

   (state-list (sequence ?id $?))

   (UI-state (id ?id)
             (relation-asserted ?relation))

   =>

   (retract ?f)

   (assert (add-response ?id)))

(defrule handle-next-no-change-middle-of-chain

   (declare (salience 10))

   ?f1 <- (next ?id ?response)

   ?f2 <- (state-list (current ?id) (sequence $? ?nid ?id $?))

   (UI-state (id ?id) (response ?response))

   =>

   (retract ?f1)

   (modify ?f2 (current ?nid))

   (halt))

(defrule handle-next-change-middle-of-chain

   (declare (salience 10))

   (next ?id ?response)

   ?f1 <- (state-list (current ?id) (sequence ?nid $?b ?id $?e))

   (UI-state (id ?id) (response ~?response))

   ?f2 <- (UI-state (id ?nid))

   =>

   (modify ?f1 (sequence ?b ?id ?e))

   (retract ?f2))

(defrule handle-next-response-end-of-chain

   (declare (salience 10))

   ?f1 <- (next ?id ?response)

   (state-list (sequence ?id $?))

   ?f2 <- (UI-state (id ?id)
                    (response ?expected)
                    (relation-asserted ?relation))

   =>

   (retract ?f1)

   (if (neq ?response ?expected)
      then
      (modify ?f2 (response ?response)))

   (assert (add-response ?id ?response)))

(defrule handle-add-response

   (declare (salience 10))

   (logical (UI-state (id ?id)
                      (relation-asserted ?relation)))

   ?f1 <- (add-response ?id ?response)

   =>

   (str-assert (str-cat "(" ?relation " " ?response ")"))

   (retract ?f1))

(defrule handle-add-response-none

   (declare (salience 10))

   (logical (UI-state (id ?id)
                      (relation-asserted ?relation)))

   ?f1 <- (add-response ?id)

   =>

   (str-assert (str-cat "(" ?relation ")"))

   (retract ?f1))

(defrule handle-prev

   (declare (salience 10))

   ?f1 <- (prev ?id)

   ?f2 <- (state-list (sequence $?b ?id ?p $?e))

   =>

   (retract ?f1)

   (modify ?f2 (current ?p))

   (halt))
