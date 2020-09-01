Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cumulusnetworks.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=JId0SkVazCDez5KK5g4ks/W/j+P2ORJmNcED9SIPLI8=;
 b=XXhM+dPf2aCaAvmFC8uGJg2kDixU79a0xCvcJZr5D6Xe/Lqc2tqiGOSrC5jGjkcgp3
 6dQ29E5h9/rgb031e7/jwaok86ClcvNb0Nah3RJaGwandOjfYY7t3EtZbFXP4xDZJpOT
 evpJeOcxK2Zf1NJp4xaRlNe8jw6W0vrTeZcW0=
References: <20200831150845.1062447-1-nikolay@cumulusnetworks.com>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <d7b03d6d-90ca-5df1-13de-33f69d8c86a8@cumulusnetworks.com>
Date: Tue, 1 Sep 2020 12:22:23 +0300
MIME-Version: 1.0
In-Reply-To: <20200831150845.1062447-1-nikolay@cumulusnetworks.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 00/15] net: bridge: mcast: initial
 IGMPv3 support (part 1)
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: bridge@lists.linux-foundation.org, davem@davemloft.net, roopa@nvidia.com

On 31/08/2020 18:08, Nikolay Aleksandrov wrote:
> Hi all,
> This patch-set implements the control plane for initial IGMPv3 support.
[snip]

Self-NAK, my torture tests uncovered (a rather obvious) locking issue with the dump
code. The src groups will have to be traversed with RCU, and thus RCU-friendly
since the mdb dump code doesn't acquire multicast_lock and we don't want to block
IGMP processing.

I'll wait with v2 to see if there are any other comments.

Thanks,
 Nik


