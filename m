Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:to:references:cc:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-transfer-encoding;
	bh=IgeZ+Th+H6Ct7euiFvlHT0hKrcBKEOYwd7qNXTd+21s=;
	b=XR1S6kD7hnai8M1qcx0GFrr8K0y9LO9zsYfr7U/4M+VO1JJ5nf9YQWbgKiJkg4a5vF
	OYtkVlDn8lnTHVg2bNfwE6ZqTeDCM3byygrgvkQTtu7MEz81PNHoi6chCRpnNgeVYBwI
	/SIOFMESWFaCM74PM/X/gQudoVhaT+8TR5Ofg=
References: <1504156693-24692-1-git-send-email-roopa@cumulusnetworks.com>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <9a4af592-87ce-20cc-d617-b00cb4f72998@cumulusnetworks.com>
Date: Thu, 31 Aug 2017 17:19:33 +0300
MIME-Version: 1.0
In-Reply-To: <1504156693-24692-1-git-send-email-roopa@cumulusnetworks.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next] bridge: add tracepoint in
	br_fdb_update
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Roopa Prabhu <roopa@cumulusnetworks.com>, davem@davemloft.net
Cc: bridge@lists.linux-foundation.org, netdev@vger.kernel.org, f.fainelli@gmail.com, andrew@lunn.ch

On 31/08/17 08:18, Roopa Prabhu wrote:
> From: Roopa Prabhu <roopa@cumulusnetworks.com>
> 
> This extends bridge fdb table tracepoints to also cover
> learned fdb entries in the br_fdb_update path. Note that
> unlike other tracepoints I have moved this to when the fdb
> is modified because this is in the datapath and can generate
> a lot of noise in the trace output. br_fdb_update is also called
> from added_by_user context in the NTF_USE case which is already
> traced ..hence the !added_by_user check.
> 
> Signed-off-by: Roopa Prabhu <roopa@cumulusnetworks.com>
> ---
>  include/trace/events/bridge.h | 31 +++++++++++++++++++++++++++++++
>  net/bridge/br_fdb.c           |  5 ++++-
>  net/core/net-traces.c         |  1 +
>  3 files changed, 36 insertions(+), 1 deletion(-)
> 

Acked-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>


