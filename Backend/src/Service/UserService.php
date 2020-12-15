<?php


namespace App\Service;


use App\AutoMapping;
use App\Entity\UserEntity;
use App\Entity\UserProfileEntity;
use App\Manager\UserManager;
use App\Request\UserProfileCreateRequest;
use App\Request\UserProfileUpdateRequest;
use App\Request\UserRegisterRequest;
use App\Response\UserProfileCreateResponse;
use App\Response\UserProfileResponse;
use App\Response\UserRegisterResponse;
use Symfony\Component\DependencyInjection\ParameterBag\ParameterBagInterface;

class UserService
{
    private $autoMapping;
    private $userManager;
    private $params;

    public function __construct(AutoMapping $autoMapping, UserManager $userManager, ParameterBagInterface $params)
    {
        $this->autoMapping = $autoMapping;
        $this->userManager = $userManager;
        $this->params = $params->get('upload_base_url').'/';
    }

    public function userRegister(UserRegisterRequest $request)
    {
        $userRegister = $this->userManager->userRegister($request);

        $response = $this->autoMapping->map(UserEntity::class,UserRegisterResponse::class, $userRegister);

        return $response;
    }

    public function userProfileCreate(UserProfileCreateRequest $request)
    {
        $userProfile = $this->userManager->userProfileCreate($request);

        $userProfile->setImage($this->params.$userProfile->getImage());

        $response = $this->autoMapping->map(UserProfileEntity::class,UserProfileCreateResponse::class, $userProfile);

        return $response;
    }

    public function userProfileUpdate(UserProfileUpdateRequest $request)
    {
        $item = $this->userManager->userProfileUpdate($request);

        $response = $this->autoMapping->map(UserProfileEntity::class,UserProfileResponse::class, $item);

        return $response;
    }

    public function getUserProfileByUserID($userID)
    {
        $itemsResponse = [];

        $items = $this->userManager->getProfileByUserID($userID);

        foreach ($items as $item)
        {
            $item['image'] = $this->params.$item['image'];

            $itemsResponse[] = $this->autoMapping->map('array', UserProfileResponse::class, $item);
        }

        return $itemsResponse;
    }

    public function getAllProfiles()
    {
        $profilesResponse = [];
        $response = [];

        $result = $this->userManager->getAllProfiles();

        foreach ($result as $row)
        {
            $profilesResponse[] = $this->autoMapping->map('array', UserProfileResponse::class, $row);
        }

        $response['Profiles'] = $profilesResponse;
        $response['ProfilesCount'] = count($profilesResponse);

        return $response;
    }
}