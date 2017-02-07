Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:to:references:cc:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-transfer-encoding;
	bh=F/uOYTZUUaccN52bk6RFrGG1J07aHblo6cO6aHe8hWM=;
	b=IYxKxTjP5x58qYHYwo2nW5pR0WhhvJeVFwRmzeEPYGog7hfPdI8iOnR+/nCybVPYOo
	Inq6J1FRDfVJxcS12TDhw55gjrbHgJHdY5y99rh/kmHa3QB1HNMGkq+Hayb/dDh1j3ME
	6Wz/QgoPsuaEDMTVfBPNIn8m+Z3w8etBzcwkw=
References: <1486227909-18319-1-git-send-email-nikolay@cumulusnetworks.com>
	<1486227909-18319-5-git-send-email-nikolay@cumulusnetworks.com>
	<20170207084646.70dc888a@xeon-e3>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <b6bf4265-bc9c-a54f-953e-0a23bfcb656b@cumulusnetworks.com>
Date: Tue, 7 Feb 2017 17:56:59 +0100
MIME-Version: 1.0
In-Reply-To: <20170207084646.70dc888a@xeon-e3>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next] bridge: avoid unnecessary read of
	jiffies
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, davem@davemloft.net

On 07/02/17 17:46, Stephen Hemminger wrote:
> 
> Jiffies is volatile so read it once.
> 
> Signed-off-by: Stephen Hemminger <sthemmin@microsoft.com>
> ---
>  net/bridge/br_fdb.c   | 6 ++++--
>  net/bridge/br_input.c | 6 ++++--
>  2 files changed, 8 insertions(+), 4 deletions(-)
> 

Yep, good catch. Maybe you can use READ_ONCE() even though it's not needed just
to show why it's done this way.

Acked-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

