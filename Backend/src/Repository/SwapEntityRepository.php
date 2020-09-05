<?php

namespace App\Repository;

use App\Entity\SwapEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @method SwapEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method SwapEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method SwapEntity[]    findAll()
 * @method SwapEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class SwapEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, SwapEntity::class);
    }

    public function getItems()
    {
        return $this->createQueryBuilder('swap')

            ->select('swap.id', 'swap.date', 'swap.userIdOne', 'swap.userIdTwo', 'swap.swapItemIdOne',
                'swap.swapItemIdTwo', 'swap.cost', 'swap.roomID', 'swap.status')

            ->orderBy('swap.id', 'ASC')

            ->getQuery()
            ->getResult();
    }

    public function getItemByID($id)
    {
        $r =  $this->createQueryBuilder('swap')

            ->andWhere('swap.id=:id')
            ->setParameter('id', $id)

            ->getQuery()
           ->getOneOrNullResult();

        return $r;
    }

    public function getItemByUserID($userID)
    {
        //dd($userID);
        $r =  $this->createQueryBuilder('swap')

            ->select('swap.id', 'swap.date', 'swap.userIdOne', 'swap.userIdTwo', 'swap.swapItemIdOne',
                'swap.swapItemIdTwo', 'swap.cost', 'swap.roomID', 'swap.status')

            ->andWhere('swap.userIdOne=:userID')
            ->setParameter('userID', $userID)
            ->orWhere('swap.userIdTwo=:userID')
            ->setParameter('userID', $userID)

            ->getQuery()
            ->getResult();
        //dd($r);
        return $r;
    }
}
