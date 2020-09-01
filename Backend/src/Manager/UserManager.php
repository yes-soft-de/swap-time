<?php


namespace App\Manager;


use App\AutoMapping;
use App\Entity\UserEntity;
use App\Entity\UserProfileEntity;
use App\Repository\UserEntityRepository;
use App\Request\UserProfileCreateRequest;
use App\Request\UserRegisterRequest;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\Security\Core\Encoder\UserPasswordEncoderInterface;

class UserManager
{
    private $autoMapping;
    private $entityManager;
    private $encoder;
    private $userRepository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager,
                                UserPasswordEncoderInterface $encoder, UserEntityRepository $userRepository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->encoder = $encoder;
        $this->userRepository = $userRepository;
    }

    public function userRegister(UserRegisterRequest $request)
    {
        $userRegister = $this->autoMapping->map(UserRegisterRequest::class, UserEntity::class, $request);

        $user = new UserEntity($request->getUserID());

        if ($request->getPassword())
        {
            $userRegister->setPassword($this->encoder->encodePassword($user, $request->getPassword()));
        }

        $userRegister->setCreateDate(new \DateTime('now'));

        if ($request->getRoles() == null)
        {
            $request->setRoles(['user']);
        }
        $userRegister->setRoles($request->getRoles());

        $this->entityManager->persist($userRegister);
        $this->entityManager->flush();
        $this->entityManager->clear();

        return $userRegister;
    }

    public function userProfileCreate(UserProfileCreateRequest $request)
    {
        $userProfile = $this->autoMapping->map(UserProfileCreateRequest::class, UserProfileEntity::class, $request);

        $this->entityManager->persist($userProfile);
        $this->entityManager->flush();
        $this->entityManager->clear();

        return $userProfile;
    }

//    public function userProfileUpdate(TouristUpdateRequest $request)
//    {
//        $tourist = $this->userRepository->getUser($request->userID);
//
//        if ($tourist)
//        {
//            if ($request->password)
//            {
//                $user = new User($request->userID);
//                $request->setPassword($this->encoder->encodePassword($user, $request->password));
//            }
//
//            $tourist = $this->autoMapping->mapToObject(TouristUpdateRequest::class,
//                User::class, $request, $tourist);
//
//            $this->entityManager->flush();
//            $this->entityManager->clear();
//            return $tourist;
//        }
//    }

    public function getUserByUserID($userID)
    {
        return $this->userRepository->getUser($userID);
    }
}