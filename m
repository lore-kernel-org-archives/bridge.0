Return-Path: <kuba@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1640798414;
 bh=mD55XiGnaxJafKvRs4q7sk9He7DhV4oGwfUm+8MHPSs=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=c871heSWCTctS4GfXo9h3MeEdIN3+xN1XMTHmku30iWA8RKuAHoL9vEPa3clSxk3I
 lYqgCYWrSaJvGEZkpKVFAlQ4aUWz0M2PkvdzVNqxJaC37+/H1MBCvkHWOKkmk8kwm1
 sM3b5PIfgSqaCVOjfeV9864HlRBayb4Fua7XLpkebqflAstoOxvBMvEvKw31u31AL2
 iTr8zj8c7GeUnyCv0B2NghKXe3exAf+GB/HqdoF3SN797ly5jlaudliZlisbwPBJMn
 kAX6iM2/LNnkDDiHXND27O7a4DttQZLqab3RVRCQmetqRSTEGQP4cWlwwRwo5w887t
 ZwiJE97ykLWog==
Date: Wed, 29 Dec 2021 09:20:12 -0800
From: Jakub Kicinski <kuba@kernel.org>
Message-ID: <20211229092012.635e9f2b@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
In-Reply-To: <5a82690c-7dc0-81de-4dd6-06e26e4b9b92@gmail.com>
References: <20211229004913.513372-1-kuba@kernel.org>
 <5a82690c-7dc0-81de-4dd6-06e26e4b9b92@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH bpf-next v2] net: don't include filter.h from
	net/sock.h
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: linux-s390@vger.kernel.org, linux-nfs@vger.kernel.org, linux-decnet-user@lists.sourceforge.net, netfilter-devel@vger.kernel.org, daniel@iogearbox.net, linux-rdma@vger.kernel.org, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-wireless@vger.kernel.org, ast@kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-can@vger.kernel.org, linux-bluetooth@vger.kernel.org, coreteam@netfilter.org, intel-wired-lan@lists.osuosl.org, linux-fsdevel@vger.kernel.org, linux-hams@vger.kernel.org, bpf@vger.kernel.org, virtualization@lists.linux-foundation.org, ath11k@lists.infradead.org

On Tue, 28 Dec 2021 17:33:39 -0800 Florian Fainelli wrote:
> It would be nice if we used the number of files rebuilt because of a 
> header file change as another metric that the kernel is evaluated with 
> from release to release (or even on a commit by commit basis). Food for 
> thought.

Maybe Andy has some thoughts, he has been working on dropping
unnecessary includes of kernel.h, it seems.

It'd be cool to plug something that'd warn us about significant
increases in dependencies into the patchwork build bot.

I have one more small series which un-includes uapi/bpf.h from
netdevice.h at which point I hope we'll be largely in the clear 
from build bot performance perspective.
