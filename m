From: Bart De Schuymer <bdschuym@pandora.be>
Subject: Re: [Bridge] Limitation in virtual bridge number
Date: Mon, 29 Mar 2004 20:23:56 +0200
References: <001901c41415$f8cf2410$f9cd00d5@kastrup>
In-Reply-To: <001901c41415$f8cf2410$f9cd00d5@kastrup>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Message-Id: <200403292023.56131.bdschuym@pandora.be>
Content-Transfer-Encoding: 8bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: =?utf-8?q?Ferm=C3=ADn=20Gal=C3=A1n?= <fgalan@teleline.es>, shemminger@osdl.org
Cc: bridge@osdl.org

On Saturday 27 March 2004 17:10, Fermín Galán wrote:
> I would like to know how can I create more
> than 32 virtual bridges (if possible).

The kernel actually creates any number of bridges. It turns out the userspace 
code only handles 32 bridges. It turns out that the kernel code that is 
executed for the show command only handles 64 bridges.

You can test this yourself by creating 33 bridges and then deleting a bridge 
that wasn't the first one you created. When listing the bridges, the first 
one you created will show up again.

The userspace tool and kernel code will need to be rewritten.

cheers,
Bart


