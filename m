Message-ID: <4B661376.4020705@dbservice.com>
Date: Mon, 01 Feb 2010 00:34:14 +0100
From: Tomas Carnecky <tom@dbservice.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010201030402020103080104"
Subject: [Bridge] Bug when using bridge + ipv6 link local addresses
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

This is a multi-part message in MIME format.
--------------010201030402020103080104
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

While trying to make distcc compatible with IPv6, I came across this.. 
uhm, bug..?

My setup: I use a bridge as my primary network interface. This is so I 
can brigde my KVM VMs with the physical network. But most of the time 
the bridge (vmnet) contains only the physical interface (eth0):

$ brctl show vmnet
bridge name	bridge id		STP enabled	interfaces
vmnet		8000.0016d3ce57d9	no		eth0

The network configuration:

$ ifconfig
eth0   Link encap:Ethernet  HWaddr 00:16:d3:ce:57:d9
        inet6 addr: fe80::216:d3ff:fece:57d9/64 Scope:Link

vmnet  Link encap:Ethernet  HWaddr 00:16:d3:ce:57:d9
        inet addr:192.168.0.82  Bcast:192.168.0.255  Mask:255.255.255.0
        inet6 addr: 2001:xxxx:xxxx:0:216:d3ff:fece:57d9/64 Scope:Global
        inet6 addr: fe80::216:d3ff:fece:57d9/64 Scope:Link

As you can see the IPv6 link local address is assigned to both vmnet and 
eth0. But I can ping both interfaces (ping6 fe80..%vmnet and %eth0) just 
fine.

I was able to create a small application which reproduces the bug. In 
short, a server listens on ::, a client connects to a link-local address 
(fe80..%eth0) and starts writing data, while the server reads it from 
the socket. After a while both processes block in read/write 
respectively and I see the following:

$ netstat -ntp
tcp6 0  53188 fe80::...:45398 fe80::....:8080 ESTABLISHED
tcp6 0      0 fe80::....:8080 fe80::...:45398 ESTABLISHED

The send-queue of the writing application has data in it, but somehow 
the reading side can't read it. When I change the client to connect to 
fe80..%vmnet (or ::1 or the global scope address) the test application 
(and distcc) work as expected.

The test application I use is attached. You should change the address 
the client is trying to connect to (line 63, replace it with your real 
link local address and append the scope id of either the bridge or the 
network interface attached to the bridge). This is the output on my box:

child: wrote 4096 bytes
child: wrote 4096 bytes
child: wrote 4096 bytes
child: wrote 4096 bytes
child: wrote 4096 bytes
child: wrote 4096 bytes
child: wrote 4096 bytes
child: wrote 4096 bytes
child: wrote 4096 bytes
child: wrote 4096 bytes
child: wrote 4096 bytes
child: wrote 4096 bytes
hostname: fe80::216:d3ff:fece:57d9%eth0
parent: read 4096 bytes
parent: read 4096 bytes
parent: read 4096 bytes
parent: read 4096 bytes
parent: read 4076 bytes

The child blocks while writing between byte 49152 and 53248 (which 
matches the contents of the send-queue), and the server blocks sometime 
after reading 20460 bytes.

I am willing to test patches, even experimental ones.

tom

--------------010201030402020103080104
Content-Type: text/x-csrc;
 name="bridge-ipv6.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="bridge-ipv6.c"

#include <arpa/inet.h>
#include <unistd.h>
#include <fcntl.h>
#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <netdb.h>
#include <netinet/in.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <string.h>
 
#ifndef   NI_MAXHOST
#define   NI_MAXHOST 1025
#endif

static void die(const char *msg)
{
	printf("%s\n", msg);
	exit(1);
}

int main(void)
{
	int err;

	struct addrinfo *res, hints = {
		.ai_family = AF_INET6,
		.ai_socktype = SOCK_STREAM,
		.ai_flags = AI_PASSIVE
	};

	/* set up the server socket (listen on ::) */
	err = getaddrinfo(NULL, "8080", &hints, &res);
	if (err)
                die(gai_strerror(err));
 
	int sock = socket(res->ai_family, res->ai_socktype, res->ai_protocol);
	if (sock < 0)
		die(strerror(errno));

	err = bind(sock, res->ai_addr, res->ai_addrlen);
	if (err)
		die(strerror(errno));

	err = listen(sock, 10);
	if (err)
		die(strerror(errno));

	freeaddrinfo(res);

	err = fcntl(sock, F_SETFD, FD_CLOEXEC);
	if (err)
                die(strerror(errno));

	pid_t child = fork();
	if (child < 0)
		die(strerror(errno));

	if (child == 0) {
		/* the child connects to the server socket and starts writing data to it */
		hints.ai_flags = 0;
		err = getaddrinfo("fe80::216:d3ff:fece:57d9%eth0", "8080", &hints, &res);
		if (err)
			die(gai_strerror(err));
		
		int fd = socket(res->ai_family, res->ai_socktype, res->ai_protocol);
		if (fd < 0)
			die(strerror(errno));
		
		err = connect(fd, res->ai_addr, res->ai_addrlen);
		if (err)
			die(strerror(errno));
		
		freeaddrinfo(res);
		
		for (;;) {
			const char buffer[4*1024];
			err = write(fd, buffer, sizeof(buffer));
			if (err < 0)
				die(strerror(errno));
			printf("child: wrote %d bytes\n", err);
		}
	} else {
		/* the server accepts the connection and starts reading from it */
		struct sockaddr_in6 sin6;
		socklen_t socklen = sizeof(sin6);
		int clientfd = accept(sock, (struct sockaddr *) &sin6, &socklen);
		if (clientfd < 0)
			die(strerror(errno));
		
		char hostname[NI_MAXHOST] = "";
		err = getnameinfo((struct sockaddr *)&sin6, socklen, hostname, NI_MAXHOST, NULL, 0, 0); 
		printf("hostname: %s\n", hostname);

		fd_set readfds;
		FD_ZERO(&readfds);
		FD_SET(clientfd, &readfds);

		for (;;) {
			err = select(clientfd + 1, &readfds, NULL, NULL, NULL);
			if (err < 0)
				die(strerror(errno));

			char buffer[4*1024];
			err = read(clientfd, buffer, sizeof(buffer));
			printf("parent: read %d bytes\n", err);

			FD_SET(clientfd, &readfds);
		}
	}
	
	return 0;
}

--------------010201030402020103080104--

