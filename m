Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:to:references:cc:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-transfer-encoding;
	bh=OCUv0KhTrDg4oJDzbA1pxWgTMLjW8AWcG2iGnAG4Mag=;
	b=BSiNjXfEfr6Jbkzu5lIhG5UvHbjEzyQWZ3vnf9lp/+QDMIb+US9DlnNFvsN+M3fk0H
	PUcE/oONYD8foq+Ry6YskksfTfQ9cNNdPQnja02IrS4XYsA4joo5Ab4M+Jh0r6hBUjT9
	UMwnPpRY46cbp+cbh1aRi09vDAKsb0Vd0t8dw=
References: <cover.1460131308.git.lucien.xin@gmail.com>
	<6e2cf6821542a253904dfc7d8ec431d6bbda2b4e.1460131308.git.lucien.xin@gmail.com>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <5708F534.4000308@cumulusnetworks.com>
Date: Sat, 9 Apr 2016 14:27:32 +0200
MIME-Version: 1.0
In-Reply-To: <6e2cf6821542a253904dfc7d8ec431d6bbda2b4e.1460131308.git.lucien.xin@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCHv3 net-next 1/6] bridge: simplify the
 flush_store by calling store_bridge_parm
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
> There are some repetitive codes in flush_store, we can remove
> them by calling store_bridge_parm, also, it would send rtnl notification
> after we add it in store_bridge_parm in the following patches.
> 
> Signed-off-by: Xin Long <lucien.xin@gmail.com>
> ---
>  net/bridge/br_sysfs_br.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 

Reviewed-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

