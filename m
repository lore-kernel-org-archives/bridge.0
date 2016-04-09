Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:to:references:cc:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-transfer-encoding;
	bh=uUj84bo2WS/C9jwnBAJZn2y3rCmDMKCSmmmiHIZTzVg=;
	b=E0ZKnTwbKUAuqm17LoS7B+o/suZJKKylR7+a4aYUbT5CIge/WcY9BlP8z9F9LYlt2I
	0HOCMys2pYTzCZmUNdZ+KDcbCltlCGuMkqNj2gVOWKNDAIiv9hrSlLKwIJ9vLT/60eaE
	li6GXQVKmAPfhcMt8rVfylTxfcJuFG20pheYo=
References: <cover.1460131308.git.lucien.xin@gmail.com>
	<6e2cf6821542a253904dfc7d8ec431d6bbda2b4e.1460131308.git.lucien.xin@gmail.com>
	<6197a35a2eb6df2caf90edcbf1b49da12077f659.1460131308.git.lucien.xin@gmail.com>
	<8c14a891d0a8bcea071d4e5305776a5c5cd9fd17.1460131308.git.lucien.xin@gmail.com>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <5708F6B1.1010109@cumulusnetworks.com>
Date: Sat, 9 Apr 2016 14:33:53 +0200
MIME-Version: 1.0
In-Reply-To: <8c14a891d0a8bcea071d4e5305776a5c5cd9fd17.1460131308.git.lucien.xin@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCHv3 net-next 3/6] bridge: simplify the
 stp_state_store by calling store_bridge_parm
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Xin Long <lucien.xin@gmail.com>, network dev <netdev@vger.kernel.org>, bridge@lists.linux-foundation.org
Cc: davem@davemloft.net

On 04/08/2016 06:03 PM, Xin Long wrote:
> There are some repetitive codes in stp_state_store, we can remove
> them by calling store_bridge_parm.
> 
> Signed-off-by: Xin Long <lucien.xin@gmail.com>
> ---
>  net/bridge/br_sysfs_br.c | 24 +++++++++---------------
>  1 file changed, 9 insertions(+), 15 deletions(-)
> 

Reviewed-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>


