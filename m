Date: Thu, 17 Jun 2004 15:52:05 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] Bridging between user processes - TAP question
Message-Id: <20040617155205.38b9dbff@dell_ss3.pdx.osdl.net>
In-Reply-To: <20040617222940.79616.qmail@web90104.mail.scd.yahoo.com>
References: <40D11F57.9070504@web.de>
	<20040617222940.79616.qmail@web90104.mail.scd.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="Multipart=_Thu__17_Jun_2004_15_52_05_-0700_=q97pnXHaQaRoE0k"
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Derek Smalls <dsmalls321@yahoo.com>
Cc: bridge@lists.osdl.org

This is a multi-part message in MIME format.

--Multipart=_Thu__17_Jun_2004_15_52_05_-0700_=q97pnXHaQaRoE0k
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Do either of these help?  I used them about a year ago when updating
tun and tap to new netdevice model.


--Multipart=_Thu__17_Jun_2004_15_52_05_-0700_=q97pnXHaQaRoE0k
Content-Type: text/plain;
 name="taptest.c"
Content-Disposition: attachment;
 filename="taptest.c"
Content-Transfer-Encoding: quoted-printable

/* Simple program to listen to /dev/tap0 and reply to pings. */
#include <fcntl.h>
#include <netinet/ip.h>
#include <netinet/ip_icmp.h>
#if defined(__GLIBC__) && (__GLIBC__ =3D=3D 2)
#include <netinet/tcp.h>
#include <netinet/udp.h>
#else
#include <linux/tcp.h>
#include <linux/udp.h>
#endif
#include <string.h>
#include <stdio.h>
#include <errno.h>
#include <unistd.h>

u_int16_t csum_partial(void *buffer, unsigned int len, u_int16_t prevsum)
{
	u_int32_t sum =3D 0;
	u_int16_t *ptr =3D buffer;

	while (len > 1)  {
		sum +=3D *ptr++;
		len -=3D 2;
	}
	if (len) {
		union {
			u_int8_t byte;
			u_int16_t wyde;
		} odd;
		odd.wyde =3D 0;
		odd.byte =3D *((u_int8_t *)ptr);
		sum +=3D odd.wyde;
	}
	sum =3D (sum >> 16) + (sum & 0xFFFF);
	sum +=3D prevsum;
	return (sum + (sum >> 16));
}

int main()
{
	int fd, len;
	union {
		struct {
			char etherhdr[16];
			struct iphdr ip;
		} fmt;
		unsigned char raw[65536];
	} u;

	fd =3D open("/dev/tap0", O_RDWR);
	if (fd < 0) {
		perror("Opening `/dev/tap0'");
		return 1;
	}

	/* u.fmt.ip.ihl in host order!  Film at 11. */
	while ((len =3D read(fd, &u, sizeof(u))) > 0) {
		u_int32_t tmp;
 		struct icmphdr *icmp
			=3D (void *)((u_int32_t *)&u.fmt.ip + u.fmt.ip.ihl );
		struct tcphdr *tcp =3D (void *)icmp;
		struct udphdr *udp =3D (void *)icmp;
	=09
		fprintf(stderr, "SRC =3D %u.%u.%u.%u DST =3D %u.%u.%u.%u\n",
			(ntohl(u.fmt.ip.saddr) >> 24) & 0xFF,
			(ntohl(u.fmt.ip.saddr) >> 16) & 0xFF,
			(ntohl(u.fmt.ip.saddr) >> 8) & 0xFF,
			(ntohl(u.fmt.ip.saddr) >> 0) & 0xFF,
			(ntohl(u.fmt.ip.daddr) >> 24) & 0xFF,
			(ntohl(u.fmt.ip.daddr) >> 16) & 0xFF,
			(ntohl(u.fmt.ip.daddr) >> 8) & 0xFF,
			(ntohl(u.fmt.ip.daddr) >> 0) & 0xFF);

		switch (u.fmt.ip.protocol) {
		case IPPROTO_ICMP:
			if (icmp->type =3D=3D ICMP_ECHO) {
				fprintf(stderr, "PONG! (iphdr =3D %u bytes)\n",
					(unsigned int)((char *)icmp
						       - (char *)&u.fmt.ip));

				/* Turn it around */
				tmp =3D u.fmt.ip.saddr;
				u.fmt.ip.saddr =3D u.fmt.ip.daddr;
				u.fmt.ip.daddr =3D tmp;

				icmp->type =3D ICMP_ECHOREPLY;
				icmp->checksum =3D 0;
				icmp->checksum
					=3D ~csum_partial(icmp,
							ntohs(u.fmt.ip.tot_len)
							- u.fmt.ip.ihl*4, 0);

				{
					unsigned int i;
					for (i =3D 44;
					     i < ntohs(u.fmt.ip.tot_len); i++){
						printf("%u:0x%02X ", i,
						       ((unsigned char *)
							&u.fmt.ip)[i]);
					}
					printf("\n");
				}
				write(fd, &u, len);
			}
			break;
		case IPPROTO_TCP:
			fprintf(stderr, "TCP: %u -> %u\n", ntohs(tcp->source),
				ntohs(tcp->dest));
			break;

		case IPPROTO_UDP:
			fprintf(stderr, "UDP: %u -> %u\n", ntohs(udp->source),
				ntohs(udp->dest));
			break;
		}
	}
	if (len < 0)
		perror("Reading from `/dev/tap0'");
	else fprintf(stderr, "Empty read from `/dev/tap0'");
	return len < 0 ? 1 : 0;
}
		=09

--Multipart=_Thu__17_Jun_2004_15_52_05_-0700_=q97pnXHaQaRoE0k
Content-Type: application/octet-stream;
 name="taptest.c"
Content-Disposition: attachment;
 filename="taptest.c"
Content-Transfer-Encoding: quoted-printable

/* Simple program to listen to /dev/tap0 and reply to pings. */
#include <fcntl.h>
#include <netinet/ip.h>
#include <netinet/ip_icmp.h>
#if defined(__GLIBC__) && (__GLIBC__ =3D=3D 2)
#include <netinet/tcp.h>
#include <netinet/udp.h>
#else
#include <linux/tcp.h>
#include <linux/udp.h>
#endif
#include <string.h>
#include <stdio.h>
#include <errno.h>
#include <unistd.h>

u_int16_t csum_partial(void *buffer, unsigned int len, u_int16_t prevsum)
{
	u_int32_t sum =3D 0;
	u_int16_t *ptr =3D buffer;

	while (len > 1)  {
		sum +=3D *ptr++;
		len -=3D 2;
	}
	if (len) {
		union {
			u_int8_t byte;
			u_int16_t wyde;
		} odd;
		odd.wyde =3D 0;
		odd.byte =3D *((u_int8_t *)ptr);
		sum +=3D odd.wyde;
	}
	sum =3D (sum >> 16) + (sum & 0xFFFF);
	sum +=3D prevsum;
	return (sum + (sum >> 16));
}

int main()
{
	int fd, len;
	union {
		struct {
			char etherhdr[16];
			struct iphdr ip;
		} fmt;
		unsigned char raw[65536];
	} u;

	fd =3D open("/dev/tap0", O_RDWR);
	if (fd < 0) {
		perror("Opening `/dev/tap0'");
		return 1;
	}

	/* u.fmt.ip.ihl in host order!  Film at 11. */
	while ((len =3D read(fd, &u, sizeof(u))) > 0) {
		u_int32_t tmp;
 		struct icmphdr *icmp
			=3D (void *)((u_int32_t *)&u.fmt.ip + u.fmt.ip.ihl );
		struct tcphdr *tcp =3D (void *)icmp;
		struct udphdr *udp =3D (void *)icmp;
	=09
		fprintf(stderr, "SRC =3D %u.%u.%u.%u DST =3D %u.%u.%u.%u\n",
			(ntohl(u.fmt.ip.saddr) >> 24) & 0xFF,
			(ntohl(u.fmt.ip.saddr) >> 16) & 0xFF,
			(ntohl(u.fmt.ip.saddr) >> 8) & 0xFF,
			(ntohl(u.fmt.ip.saddr) >> 0) & 0xFF,
			(ntohl(u.fmt.ip.daddr) >> 24) & 0xFF,
			(ntohl(u.fmt.ip.daddr) >> 16) & 0xFF,
			(ntohl(u.fmt.ip.daddr) >> 8) & 0xFF,
			(ntohl(u.fmt.ip.daddr) >> 0) & 0xFF);

		switch (u.fmt.ip.protocol) {
		case IPPROTO_ICMP:
			if (icmp->type =3D=3D ICMP_ECHO) {
				fprintf(stderr, "PONG! (iphdr =3D %u bytes)\n",
					(unsigned int)((char *)icmp
						       - (char *)&u.fmt.ip));

				/* Turn it around */
				tmp =3D u.fmt.ip.saddr;
				u.fmt.ip.saddr =3D u.fmt.ip.daddr;
				u.fmt.ip.daddr =3D tmp;

				icmp->type =3D ICMP_ECHOREPLY;
				icmp->checksum =3D 0;
				icmp->checksum
					=3D ~csum_partial(icmp,
							ntohs(u.fmt.ip.tot_len)
							- u.fmt.ip.ihl*4, 0);

				{
					unsigned int i;
					for (i =3D 44;
					     i < ntohs(u.fmt.ip.tot_len); i++){
						printf("%u:0x%02X ", i,
						       ((unsigned char *)
							&u.fmt.ip)[i]);
					}
					printf("\n");
				}
				write(fd, &u, len);
			}
			break;
		case IPPROTO_TCP:
			fprintf(stderr, "TCP: %u -> %u\n", ntohs(tcp->source),
				ntohs(tcp->dest));
			break;

		case IPPROTO_UDP:
			fprintf(stderr, "UDP: %u -> %u\n", ntohs(udp->source),
				ntohs(udp->dest));
			break;
		}
	}
	if (len < 0)
		perror("Reading from `/dev/tap0'");
	else fprintf(stderr, "Empty read from `/dev/tap0'");
	return len < 0 ? 1 : 0;
}
		=09

--Multipart=_Thu__17_Jun_2004_15_52_05_-0700_=q97pnXHaQaRoE0k--
