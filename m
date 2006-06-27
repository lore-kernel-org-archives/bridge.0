From: "Kirti S. Bajwa" <kbajwa@tibonline.net>
Date: Tue, 27 Jun 2006 10:46:39 -0400
Message-ID: <00d801c699f8$82472e80$20ed150c@SunShine>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
In-Reply-To: <1151417461.14087.10.camel@localhost.localdomain>
Subject: Re: [Bridge] bridge+filter+failover+rules&state sync+traffic shaping
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

I am working on the same project. Any help is highly appreciated.

Kirt

-----Original Message-----
From: bridge-bounces@lists.osdl.org [mailto:bridge-bounces@lists.osdl.org]
On Behalf Of Tristan DEFERT
Sent: Tuesday, June 27, 2006 10:11 AM
To: bridge@lists.osdl.org
Subject: [Bridge] bridge+filter+failover+rules&state sync+traffic shaping

hi list!
i'm trying to find a convenient way to build a redundant filtering
bridge under linux

i looked at carp project, but carp doesn't support bridge

now i thing the most appropriate way is using stp or rstp
it seems that 2.6 kernel supports stp but what about rstp?

I read some docs about stp, but they are rather outdated (2001 and
kernel 2.2)

there are several problems indeed: 
* rstp support
* fw state sync
* fw rules sync

did some of you resolve these problems?

any help appreciated, i'm rather confused between rstp, stp, ct_sync,
conntrackd ...

ps: next step will be trafic shaping / load balancing implementation
within this setup, again, any help appreciated!

_______________________________________________
Bridge mailing list
Bridge@lists.osdl.org
https://lists.osdl.org/mailman/listinfo/bridge



