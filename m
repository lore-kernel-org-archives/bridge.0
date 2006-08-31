Date: Thu, 31 Aug 2006 19:31:56 +0200
From: Boris =?iso-8859-15?Q?Dor=E8s?= <babal@via.ecp.fr>
Message-ID: <20060831173156.GC2801@via.ecp.fr>
References: <131411580608310945p1dd9bbe4jcb7468adc43196dc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <131411580608310945p1dd9bbe4jcb7468adc43196dc@mail.gmail.com>
Subject: Re: [Bridge] Trouble with ARP traffic
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Raffaele Carla <raffaele.carla@gmail.com>
Cc: bridge@lists.osdl.org

On Thu, Aug 31, 2006 at 12:45:44PM (GMT-0400), Raffaele Carla wrote:
> As a bridge, the Linux box should be  aware where every machine is located
> and separate logically the two segments,  shouldn't it?

  No. Arp is there to find out where an *IP* address is located. The
bridge doesn't even know what IP is, and therefore transmits arp
exactly like other frames.

> Also, the command "arp –a" shows only one address, wether the "brctl
> showmacs br0" shows all the addresses correctly. Is this a normal
> behaviour?

  Yes. "arp -a" lists the addresses that the *host* knows. The bridge
has its own independant database. Not all the frames that pass through
the bridge are transmitted to upper layers, only the ones with the mac
address of the host (and broadcast) are.

-- 
Boris Dorès
