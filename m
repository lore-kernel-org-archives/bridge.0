Date: Thu, 18 May 2006 10:40:05 -0400
From: "John W. Linville" <linville@tuxdriver.com>
Subject: Re: [Bridge] VLAN translation + PVST+
Message-ID: <20060518143959.GB21325@tuxdriver.com>
References: <446BC951.2050803@us.checkpoint.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <446BC951.2050803@us.checkpoint.com>
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Ian Schwimmer <ischwimm@us.checkpoint.com>
Cc: bridge@lists.osdl.org

On Wed, May 17, 2006 at 06:09:37PM -0700, Ian Schwimmer wrote:
> Hello, I am creating a configuration where a Redhat server running 
> bridge-tools 0.9.5 will be bridging between different VLANs on the same 
> physical interface (for example: a bridge consisting of eth1.100 and 
> eth1.110). This physical interface is being connected to modern Cisco 
> switches running PVST+.

I'm curious as to how this is useful?  What is the point of having
two VLANs on the same segment if you are just going to bridge them
together?  Is this useful for something beyond some sort of migration?

Curious,

John
-- 
John W. Linville
linville@tuxdriver.com
