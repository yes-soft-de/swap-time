<?php


namespace App\Controller;


use App\Entity\CommentEntity;
use App\Entity\ImageEntity;
use App\Entity\Interaction;
use App\Entity\ReportEntity;
use App\Entity\SettingEntity;
use App\Entity\SwapEntity;
use App\Entity\SwapItemEntity;
use App\Entity\UserEntity;
use App\Entity\UserProfileEntity;
use Symfony\Component\Routing\Annotation\Route;

class EraseController extends BaseController
{
    /**
     * @Route("eraseall", name="deleteAllData", methods={"DELETE"})
     */
    public function eraseAllData()
    {
        try
        {
            $em = $this->getDoctrine()->getManager();

            $swap = $em->getRepository(SwapEntity::class)->createQueryBuilder('swap')
                ->delete()
                ->getQuery()
                ->execute();

            $swapItems = $em->getRepository(SwapItemEntity::class)->createQueryBuilder('swapItem')
                ->delete()
                ->getQuery()
                ->execute();

            $usersProfiles = $em->getRepository(UserProfileEntity::class)->createQueryBuilder('profile')
                ->delete()
                ->getQuery()
                ->execute();

            $report = $em->getRepository(ReportEntity::class)->createQueryBuilder('report')
                ->delete()
                ->getQuery()
                ->execute();

            $comments = $em->getRepository(CommentEntity::class)->createQueryBuilder('comment')
                ->delete()
                ->getQuery()
                ->execute();

            $interactions = $em->getRepository(Interaction::class)->createQueryBuilder('interaction')
                ->delete()
                ->getQuery()
                ->execute();

            $images = $em->getRepository(ImageEntity::class)->createQueryBuilder('image')
                ->delete()
                ->getQuery()
                ->execute();

            $users = $em->getRepository(UserEntity::class)->createQueryBuilder('user')
                ->delete()
                ->getQuery()
                ->execute();

            $setting = $em->getRepository(SettingEntity::class)->createQueryBuilder('setting')
                ->delete()
                ->getQuery()
                ->execute();
        }
        catch (\Exception $ex)
        {
            return $this->json($ex);
        }

        return $this->response("", self::DELETE);
    }
}