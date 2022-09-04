<?php

class Base
{
    /**
     * Récupération des catégories à partir d'une requête SQL
     * @return array Tableau des catégories : les enregistrements sont stockés dans un tableau numérique
     */
    public  static function getLesCategories() : array  {
        $mois = date('m');
        $annee = date('Y');
        // l'année de référence sera l'année n + 1 si on se trouve après le mois de référence
        if ($mois >= 9) $annee++;
        $sql = <<<EOD
              Select nom, id, ageMin, ageMax, $annee - ageMax as anneeMin, $annee - ageMin as anneeMax 
              from categorie
              order by agemin;
EOD;
        $db = Database::getInstance();
        $curseur = $db->query($sql);
        $lesLignes = $curseur->fetchAll(PDO::FETCH_NUM);
        $curseur->closeCursor();
        return $lesLignes;
    }

    /**
     * Récupération des catégories par l'appel d'une procédure stockée
     * @return array
     */
    public  static function getLesCategories2() : array  {
        $mois = date('m');
        $annee = date('Y');
        // l'année de référence sera l'année n + 1 si on se trouve après le mois de référence
        if ($mois >= 9) $annee++;
        $db = Database::getInstance();
        // $curseur = $this->db->query("call getLesCategories($annee)");
        $curseur = $db->prepare("call getLesCategories(:annee)");
        $curseur->bindParam('annee', $annee);
        $curseur->execute();
        $lesLignes = $curseur->fetchAll(PDO::FETCH_NUM);
        $curseur->closeCursor();
        return $lesLignes;
    }

}