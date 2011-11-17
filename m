Return-Path: <contact@livenet.it>
Message-ID: <007b01cca4f0$f95e39b0$060ca8c0@sviluppo>
From: "Valerio Granato" <contact@livenet.it>
References: <1320941934-3534-1-git-send-email-holger.brunck@keymile.com><20111114.003702.1097206603722725705.davem@davemloft.net><1321254211.4072.29.camel@pc005091.de.keymile.net>
	<20111114.020749.1176229013272872343.davem@davemloft.net>
Date: Thu, 17 Nov 2011 07:19:16 +0100
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] net,
	bridge: print log message after state changed
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

---- Original Message ----
From: "David Miller" <davem@davemloft.net>
To: <Wolfgang.Fritz@keymile.com>
Cc: <netdev@vger.kernel.org>; <shemminger@linux-foundation.org>;
<bridge@lists.linux-foundation.org>; <holger.brunck@keymile.com> Sent:
Monday, November 14, 2011 8:07 AM Subject: Re: [Bridge] [PATCH]
net,bridge: print log message after state changed 

> I would never expect an "entering" message to print out after the
> event happens, and in fact I'd _always_ want to see it beforehand so
> that if the state change caused a crash or similar it'd be that much
> easier to pinpoint the proper location.

I think this is a really good point of view.
I agree.

Valerio
