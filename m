Date: Mon, 6 Oct 2003 16:31:31 +0200
From: Santiago Garcia Mantinan <manty@manty.net>
Message-ID: <20031006143131.GA2325@man.beta.es>
References: <20030927202200.GA612@man.beta.es>
	<p05111b00bba2061773df@[10.96.96.13]>
	<20031002160041.47053537.shemminger@osdl.org>
	<20031004155435.GB1174@man.beta.es>
	<20031006051132.GD12912@conectiva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031006051132.GD12912@conectiva.com.br>
Subject: [Bridge] Re: bridge breaks loopback on 2.4.22
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Cc: linux-net@vger.kernel.org, Hannes Schulz <schulz@schwaar.com>, marcelo.tosatti@cyclades.com, bridge@osdl.org, Stephen Hemminger <shemminger@osdl.org>

> but is now freed by kfree hits the packet sniffer... b00m, or it is being used
> for something else or is outright damaged, or both.

Well, the thing is that the problem here was that the loopback was behaving
like it was loosing packages, nothing to do with the packet sniffer, in
fact, very same thing (packets lost and connection interrupted) happened
without putting the sniffer in the middle, the sniffer was put there just to
diagnose the problem, it didn't have any effect on the problem.

Thanks for your info!

Regards...
-- 
Manty/BestiaTester -> http://manty.net
