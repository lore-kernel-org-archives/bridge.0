Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:to:references:cc:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-transfer-encoding;
	bh=+xLZawuiFIsELy62baflbRjhuxLhOfbmlCltdBu3924=;
	b=bWRzoiE5uBvP27sfWhWdTPpxvPaAZizRGrK0z+fwZhKYHaV1EOFQnXy5eh5/I4unfU
	lGKg2qeyih2qqZrA5qc62zW14Wvg9RmeVjU05JkcRiwiNPVAUYL2ElKHO2nJH3SWPW4f
	ot9knqT8WuzyC1dTNHVN831yJLBzA6oEdqIQs=
References: <1493280485-37845-1-git-send-email-arkadis@mellanox.com>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <b096c9c6-481a-6d87-6d4e-99479d78a089@cumulusnetworks.com>
Date: Thu, 27 Apr 2017 15:33:33 +0300
MIME-Version: 1.0
In-Reply-To: <1493280485-37845-1-git-send-email-arkadis@mellanox.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next] net: bridge: Fix improper taking over
 HW learned FDB
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Arkadi Sharshevsky <arkadis@mellanox.com>, netdev@vger.kernel.org
Cc: Ido Schimmel <idosch@mellanox.com>, bridge@lists.linux-foundation.org, davem@davemloft.net

On 27/04/17 11:08, Arkadi Sharshevsky wrote:
> Commit 7e26bf45e4cb ("net: bridge: allow SW learn to take over HW fdb
> entries") added the ability to "take over an entry which was previously
> learned via HW when it shows up from a SW port".
> 
> However, if an entry was learned via HW and then a control packet
> (e.g., ARP request) was trapped to the CPU, the bridge driver will
> update the entry and remove the externally learned flag, although the
> entry is still present in HW. Instead, only clear the externally learned
> flag in case of roaming.
> 
> Fixes: 7e26bf45e4cb ("net: bridge: allow SW learn to take over HW fdb entries")
> Signed-off-by: Ido Schimmel <idosch@mellanox.com>
> Signed-off-by: Arkadi Sharashevsky <arkadis@mellanox.com>
> Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
> ---
>  net/bridge/br_fdb.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Thanks!

Acked-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>


