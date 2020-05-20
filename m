Return-Path: <stephen@networkplumber.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=PGt5BLdFYxU6z1cqTJIqi+js4tZYCy5XiqwrbJue7TA=;
 b=VBDVFrk6oKnVNDIw8raagKq5a8eJuK45dEaNEJhAanbz91rxFKnrQTllLBUsf1VmYC
 NoqgnZ2zzAHzxt/ftq82ycjy2pqQDQCGwnNPuNsAedzasPPDynnRSobblUVi2uAjP81x
 dloti4nJ8TCEoIefrSsNa+yBd5be88qsolNL9eu+S30O7URyhU7bdMrCvhOIgp/x2nh8
 VaJJHi5duJo24MpKRBmNnqCLc/OoeNEceeU7MEBsNfXTkm9fRGgI4MpAQZUCvNZfpOjZ
 aj/YNjC383Z9TeAONWCxS25M+59WYmG0oUtYGird2unKBRZuTIzj3PUiAQJTAtNiMlh/
 rSTQ==
Date: Wed, 20 May 2020 08:50:54 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20200520085054.2031ad8a@hermes.lan>
In-Reply-To: <20181116165001.30896-1-nikolay@cumulusnetworks.com>
References: <20181114172703.5795-1-nikolay@cumulusnetworks.com>
 <20181116165001.30896-1-nikolay@cumulusnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net v3] net: bridge: fix vlan stats
 use-after-free on destruction
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc: netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, syzkaller-bugs@googlegroups.com, davem@davemloft.net

On Fri, 16 Nov 2018 18:50:01 +0200
Nikolay Aleksandrov <nikolay@cumulusnetworks.com> wrote:

> +	if (v->priv_flags & BR_VLFLAG_PER_PORT_STATS)
>  		free_percpu(v->stats);

Why not not v->stats == NULL as a flag instead?

Then the fact that free_percpu(NULL) is a Nop would mean less code
in the bridge driver.
