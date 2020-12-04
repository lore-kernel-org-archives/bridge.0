Return-Path: <kuba@kernel.org>
Date: Fri, 4 Dec 2020 08:11:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1607098314;
 bh=t7l9nX5UkyKRq8h2G9WlrGZktfzK+n7e18YEE+2zpCE=;
 h=From:To:Cc:Subject:In-Reply-To:References:From;
 b=h/AS4nNJ48FNWSpNFkSAToFJ+zj6dTgm1ogidDY9A+ScjDObCwrPJfBLaZZY4DczW
 3q6mpw/NKC7fyD1HdLBZglXgK5sabbUr6MggDNZiyxgd662lL/KHQmflzw2tqZHiJv
 BnoBhUTUznIx3YSsScLRHMPVUOjQTnfQbrm5pYmlpNyB6ny978fBz3+utogOxhPXnd
 0L4ECSf3ze8Blthlk/3F9LNGHHjyNcLcA5GcMWvmHUrnUMIZFOJduUZc82d1Kh1EnN
 vfowxW0x5nS4IeMtGaewsZDR1t7pxamDhrTWQEUFjwduhlRRVYzCvB8ocIU0PHM/cR
 IQo267aFJKdZQ==
From: Jakub Kicinski <kuba@kernel.org>
Message-ID: <20201204081153.496626f6@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
In-Reply-To: <75cf7844-8df7-0ea2-1980-ff868a1bc34e@nvidia.com>
References: <20201201214047.128948-1-Joseph.Huang@garmin.com>
 <20201203102802.62bc86ba@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
 <bd84ca4c-c694-6fd2-81ef-08e9253c18a4@nvidia.com>
 <c82ce96d74ed4d3897d2e68a258f7834@garmin.com>
 <2b96b845990e4a84a3b3fd46f4138ac6@garmin.com>
 <75cf7844-8df7-0ea2-1980-ff868a1bc34e@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] bridge: Fix a deadlock when enabling multicast
	snooping
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "Huang, Joseph" <Joseph.Huang@garmin.com>
Cc: netdev@vger.kernel.org, "bridge@lists.linux-foundation.org\" <bridge@lists.linux-foundation.org>,
 "@osuosl.org, "  <netdev@vger.kernel.org>, "@osuosl.org, linux-kernel@vger.kernel.org, "  <linux-kernel@vger.kernel.org>,
 Linus =?UTF-8?B?TMO8c3Npbmc=?=  <linus.luessing@c0d3.blue>"@osuosl.org, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, "David S. Miller" <davem@davemloft.net>

On Fri, 4 Dec 2020 01:34:57 +0200 Nikolay Aleksandrov wrote:
> Please add a comment why it's needed, so we won't wonder about it
> later. And also include the trace in the commit message so we'd have
> it.

And please drop the empty line between the Fixes tag and your sign-off.
We like tags all clustered together at the end, sort of reverse of
email headers.
