Date: Mon, 14 May 2007 09:04:46 -0700
From: Stephen Hemminger <shemminger@linux-foundation.org>
Subject: Re: [Bridge] Performance and limitations of virtual bridges
Message-ID: <20070514090446.485e5dd2@freepuppy>
In-Reply-To: <005301c790d6$0d61c1e0$303d5854@cttc.es>
References: <005301c790d6$0d61c1e0$303d5854@cttc.es>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: =?UTF-8?B?RmVybcOtbiBHYWzDoW4gTcOhcnF1ZXo=?= <fermin.galan@cttc.es>
Cc: bridge@lists.osdl.org, xen-users@lists.xensource.com

On Mon, 7 May 2007 20:32:17 +0200
Fermín Galán Márquez <fermin.galan@cttc.es> wrote:

> Hi,
> 
> Is there a limit in the number of interfaces a virtual bridge (created with
> brctl) can support without having a severe impact in performance?

The problem with lots of interfaces is that if destination address is not
known (or multicast/broadcast) the packet has to be copied and sent N times.

> I guess that there is no absolute answer for that question :), but maybe
> there is some kind of procedure/tool to know the "stress" or "load" that a
> virtual bridge is supporting in a given moment (in a similar way that a
> "top" can show you the CPU load).

Worst case is the flooding problem.

> My question is due to I'm using a virtual bridge with 14 interfaces (each
> interface correspond to a Xen virtual machine in the same physical host)
> and, given that I'm experiencing transmission delays in the network
> supported by the bridge, I'm suspecting about a loss of performance of it.

Probably when flooding it has to wake up all the guest machines and
that is sucking your performance on hypervisor switches.

> Thanks in advance!
> 
> Best regards,
> 
> --------------------
> Fermín Galán Márquez
> CTTC - Centre Tecnològic de Telecomunicacions de Catalunya
> Parc Mediterrani de la Tecnologia, Av. del Canal Olímpic s/n, 08860
> Castelldefels, Spain
> Room 1.02
> Tel : +34 93 645 29 12
> Fax : +34 93 645 29 01
> Email address: fermin dot galan at cttc dot es 
> 
> 
> 
> _______________________________________________
> Bridge mailing list
> Bridge@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/bridge


-- 
Stephen Hemminger <shemminger@linux-foundation.org>

