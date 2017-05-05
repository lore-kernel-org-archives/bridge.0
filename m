Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:to:references:cc:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-transfer-encoding;
	bh=daUZ06wjqQk/NyT8LkkvVL2zJuTDZAOAxlgJZDEgqhs=;
	b=UdhmnyI9ZGoxBeT2h57k+2LstXqmWEeASwQOYlhOrVTMy7m6T24hxQmM1UOWZXzbzu
	QzGxZKqHrZdr/2ayuuC2+fCLP3fHD84Yjj6TxRJCAy7yM2rg3wLJW7eZBrd5q0WZ0BBS
	UQMlnrFMMTwGdd0R2byAcWdcfnv0JvrTUldos=
References: <20170505143653.8486-1-tklauser@distanz.ch>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <99166e63-9a78-60ad-7dae-98e1fd445cf1@cumulusnetworks.com>
Date: Fri, 5 May 2017 17:55:23 +0300
MIME-Version: 1.0
In-Reply-To: <20170505143653.8486-1-tklauser@distanz.ch>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net] bridge: netlink: account for
 IFLA_BRPORT_{B, M}CAST_FLOOD size and policy
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Tobias Klauser <tklauser@distanz.ch>, Stephen Hemminger <stephen@networkplumber.org>, "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Mike Manning <mmanning@brocade.com>

On 05/05/17 17:36, Tobias Klauser wrote:
> The attribute sizes for IFLA_BRPORT_MCAST_FLOOD and
> IFLA_BRPORT_BCAST_FLOOD weren't accounted for in br_port_info_size()
> when they were added. Do so now and also add the corresponding policy
> entries:
> 
> Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
> Cc: Mike Manning <mmanning@brocade.com>
> Fixes: b6cb5ac8331b ("net: bridge: add per-port multicast flood flag")
> Fixes: 99f906e9ad7b ("bridge: add per-port broadcast flood flag")
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
> ---
>  net/bridge/br_netlink.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Oops, good catch.

Acked-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>


