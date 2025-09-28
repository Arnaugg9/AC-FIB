#include "CacheSim.h"
#include <stdio.h>

/* Posa aqui les teves estructures de dades globals
 * per mantenir la informacio necesaria de la cache
 * */

typedef struct {
	int v;
	int etq;
} Cache;

	Cache cache[128];
	unsigned int hits;
	unsigned int misses;

/* La rutina init_cache es cridada pel programa principal per
 * inicialitzar la cache.
 * La cache es inicialitzada al comen�ar cada un dels tests.
 * */
void init_cache ()
{
	/* Escriu aqui el teu codi */
	hits = 0;
	misses = 0;

	for (int i = 0; i < 128; ++i) cache[i].v = 0;
}

/* La rutina reference es cridada per cada referencia a simular */ 
void reference (unsigned int address, unsigned int LE)
{
	unsigned int byte;
	unsigned int bloque_m; 
	unsigned int linea_mc;
	unsigned int tag;
	unsigned int miss;
	unsigned int lec_mp;
	unsigned int mida_lec_mp;
	unsigned int esc_mp;
	unsigned int mida_esc_mp;
	unsigned int replacement;
	unsigned int tag_out;

	/* Escriu aqui el teu codi */

	unsigned int a = address;

	byte = a & 31;
	a = a >> 5;
	bloque_m = a;
	linea_mc = a & 127;
	tag = a >> 7;
	tag_out = -1;
	mida_esc_mp = 0;
	mida_lec_mp = 0;
	
	miss = (cache[linea_mc].v == 0 || cache[linea_mc].etq != tag);
	lec_mp = !LE && miss;
	esc_mp = LE;
	replacement = (cache[linea_mc].v != 0 && cache[linea_mc].etq != tag && lec_mp);

	if (lec_mp && !replacement) {		//si esta vacio
		cache[linea_mc].etq = tag;
		cache[linea_mc].v = 1;
		mida_lec_mp = 32;
	}
	else if (lec_mp && replacement) {		//algoritmo de reemplazo
		tag_out = cache[linea_mc].etq;
		cache[linea_mc].etq = tag;
		mida_lec_mp = 32;
	}
	else if (esc_mp) mida_esc_mp = 1;

	if (miss) ++misses;
	else ++hits;

	/* La funcio test_and_print escriu el resultat de la teva simulacio
	 * per pantalla (si s'escau) i comproba si hi ha algun error
	 * per la referencia actual
	 * */
	test_and_print (address, LE, byte, bloque_m, linea_mc, tag,
			miss, lec_mp, mida_lec_mp, esc_mp, mida_esc_mp,
			replacement, tag_out);
}

/* La rutina final es cridada al final de la simulacio */ 
void final ()
{
 	/* Escriu aqui el teu codi */ 
	printf("Nombre Hits: %d\n", hits);
	printf("Nombre Misses: %d\n", misses);
  
}
