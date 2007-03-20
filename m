Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Tue, 20 Mar 2007 09:40:34 -0000
Message-ID: <BB501CE635E5144CA5E30956E5E32C52271F18@exchange-be5.lancs.local>
References: <BB501CE635E5144CA5E30956E5E32C52271F0E@exchange-be5.lancs.local><BB501CE635E5144CA5E30956E5E32C52271F0F@exchange-be5.lancs.local><eth3uu$drn$1@sea.gmane.org>
	<20070319112751.3a227ccd@dxpl.pdx.osdl.net>
From: "Egi, Norbert" <n.egi@lancaster.ac.uk>
Content-Transfer-Encoding: 8bit
Subject: Re: [Bridge] Performance loss with bridging+routing.
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <shemminger@linux-foundation.org>, Jason Lunz <lunz@falooley.org>
Cc: bridge@linux-foundation.org

Hi
 
>If you are doing simple bridging or routing performance is about
>the same. I see about 380K packets per second or more depending
>on bus speed and network interface card.
>
>But if you do filtering then your performance can easily get CPU
>limited, especially if you are doing connection tracking.  The problem
>is that filtering ends up reading the whole packet.

The case is that I'm not doing any filtering at all, the packet entering the bridge goes up to the IP layer (instead of bridged to another interface) where it is recognized that it has to be routed to another port and after routing it leaves the machine on another port directly. On its way out it shouldn't even enter the bridge attached to the outgoing interface, so the extra processing is done only in the incoming port's bridge compared to simple routing. However, I have been tracing the packet in the kernel so now I more or less know what path the packet 'travels' in the kernel and now I'm going to use oprofile to find out where the bottleneck is and where the packets got dropped. Hopefully can find the answer to the question...

Norbert


_______________________________________________
Bridge mailing list
Bridge@lists.linux-foundation.org
https://lists.linux-foundation.org/mailman/listinfo/bridge


