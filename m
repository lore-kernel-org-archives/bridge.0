Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:to:references:cc:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-transfer-encoding;
	bh=XVA4J/Yur3l5ka3OQ6n7zqfcNe2Kf2hnzbZqhsD2hq0=;
	b=YY8h4nDZNgdeoiYm2mw4OcaQlJRAKfFPeXx6JfkxZn+6nrALKcjgA/R0NBvJqnTLMB
	+84/VxwbvcLVJl6Ct055O6g60KYgBiV3lIjAipJkWU/TFwke/afjXF1C+jCQJ2FShE+1
	g2ufZkD9Cu9h0T8QIyC6TlRINGso22DN/TCAs=
References: <1490264833-28867-1-git-send-email-nikolay@cumulusnetworks.com>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <df54a306-debc-5c90-e0f1-b06fdf15f424@cumulusnetworks.com>
Date: Thu, 23 Mar 2017 14:48:35 +0200
MIME-Version: 1.0
In-Reply-To: <1490264833-28867-1-git-send-email-nikolay@cumulusnetworks.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 0/2] net: bridge: allow user-space to
 add ext learned entries
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: jiri@resnulli.us, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, idosch@mellanox.com, davem@davemloft.net

On 23/03/17 12:27, Nikolay Aleksandrov wrote:
> Hi,
> This set adds the ability to add externally learned entries from
> user-space. For symmetry and proper function we need to allow SW entries
> to take over HW learned ones (similar to how HW can take over SW entries
> currently) which is needed for our use case (evpn) where we have pure SW
> ports and HW ports mixed in a single bridge. This does not play well with
> switchdev devices currently because there's no feedback when the entry is
> taken over, but this case has never worked anyway and feedback can be
> easily added when needed.
> Patch 02 simply allows to use NTF_EXT_LEARNED from user-space, we already
> have Quagga patches that make use of this functionality.
> 
> Thanks,
>  Nik
> 

A minor clarification: the functionality is necessary so the aging can
be handled by user-space software (e.g. quagga w/ evpn) when the entry
has been learned externally, but can also dynamically move to a local
bridge port and then the aging should be done by the bridge.



