Date: Tue, 3 May 2005 09:09:33 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Message-ID: <20050503090933.556e1b64@localhost.localdomain>
In-Reply-To: <200504241453.j3OErfs3024041@smtp.osdl.org>
References: <200504241453.j3OErfs3024041@smtp.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Re: A question about modify bridge source
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: wan <wrath8x@163.com>
Cc: bridge <bridge@lists.osdl.org>

On Sun, 24 Apr 2005 22:54:56 +0800
"wan" <wrath8x@163.com> wrote:

> 
> Hello,
> 
> I just made some change of the bridge source which under kernel 2.4.20 ,to make it work automatically without any ioctl commands such as brctl .In this module I do ,it has only one br named BRIDGE which auto constructed in the module initiation ,and defined as a global variable "brg".And I add one eth card(eth0) to the br as a port .The main program is just below this page.
> 
> But now I meet one question ,that is ,when I want passup a skb to the higher protocol layer use function netif_rx ,the higher layer not response ,the skb must have not passup yet .Why ?I'm puzzling about it for some days .

Did you put an IP address on the bridge device? 
Is the bridge device maked as UP?

If not, then the higher layers will probably drop it because it is not destined for the local host.
