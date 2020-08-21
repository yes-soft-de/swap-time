<?php


namespace App\Service;


use Gedmo\Sluggable\Util\Urlizer;
use Liip\ImagineBundle\Imagine\Cache\CacheManager;
use Liip\ImagineBundle\Service\FilterService;
use Symfony\Component\HttpFoundation\File\UploadedFile;

class UploadFileService
{
    //on server just revers this stupid windows slash -_-
    const ROOT_FOLDER = '\SwapTime-Backend';
    const BASE_UPLOAD_FOLDER = '/upload/';
    const IMAGE_FOLDER = 'image/';
    const ORIGINAL_IMAGE = 'original-image/';
    const RESOLVE_IMAGE = 'resolve-image/';

    private $uploadPath;
    private $cacheManager;
    /**
     * @var FilterService
     */
    private $filterService;

    public function __construct(string $uploadPath, CacheManager $cacheManager, FilterService $filterService)
    {
        $this->uploadPath = explode(self::ROOT_FOLDER, $uploadPath)[0];
        $this->cacheManager = $cacheManager;
        $this->filterService = $filterService;
    }

    public function uploadImage(UploadedFile $uploadedFile): string
    {
        $path = self::IMAGE_FOLDER.self::ORIGINAL_IMAGE;
        $destination = $this->getPublicPath($path);

        $originalFileName = pathinfo($uploadedFile->getClientOriginalName(),PATHINFO_FILENAME);

        $newFileName = Urlizer::urlize($originalFileName).'-'.uniqid().'.'.$uploadedFile->guessExtension();

        $uploadedFile->move($destination, $newFileName);
        //dd($newFileName);
        //
        $resolve = $this->filterService->getUrlOfFilteredImage($newFileName, 'basic');

        //$this->moveResolvedImage($resolve);

        return $resolve;//$path.$newFileName;
    }

    public function getPublicPath(string $path): string
    {
        $destination = $this->uploadPath.self::BASE_UPLOAD_FOLDER.$path;

        return $destination;
    }

//    public function moveResolvedImage(UploadedFile $uploadedFile)
//    {
//        $path = self::IMAGE_FOLDER.self::ORIGINAL_IMAGE;
//        $destination = $this->getPublicPath($path);
//
//        $uploadedFile->move($destination.'/a', 'KENAN');
//    }
}