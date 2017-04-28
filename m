Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:to:references:cc:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-transfer-encoding;
	bh=8xd9MhNXQDpi7wnkp09mSUPCtyjMMU5Lia6yABj5UOI=;
	b=C/d2ms0mBOP/sJHhuliavqcWXxe9089hSQ//SrZ9gki8X1nlbTFchLrSMmIm8qkLSH
	XsBfvJ7DsLp/ZsiRw+Z68utVrlu5UF0GZ28kFWDgM8oohptL3w0UqOHAMA7pyroG0XJe
	U7hIL3yUGheiEKJMtKMGlFy1IGmswjgqGSj+s=
References: <1493408347-44779-1-git-send-email-arkadis@mellanox.com>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <0f46c6a6-3d9a-f577-b851-d1d89c293ec9@cumulusnetworks.com>
Date: Sat, 29 Apr 2017 00:33:32 +0300
MIME-Version: 1.0
In-Reply-To: <1493408347-44779-1-git-send-email-arkadis@mellanox.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v3] net: bridge: Fix improper taking
 over HW learned FDB
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

On 28/04/17 22:39, Arkadi Sharshevsky wrote:
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
> v1->v2
> - net-next rebase.
> 
> v2->v3
> - remove redundant line.
> ---
>  net/bridge/br_fdb.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>


