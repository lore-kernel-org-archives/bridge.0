Date: Thu, 17 Mar 2005 09:45:44 -0800
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] (no subject)
Message-ID: <20050317094544.081aed75@dxpl.pdx.osdl.net>
In-Reply-To: <200503171730.j2HHUrqh029418@smtp.osdl.org>
References: <200503171730.j2HHUrqh029418@smtp.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: dyf <duziziii@163.com>
Cc: bridge <bridge@osdl.org>

On Fri, 18 Mar 2005 01:30:43 +0800
"dyf" <duziziii@163.com> wrote:

> hi:
> i want to build a bridge through my ethernet card and my wireless device,which connects with
> the mainboard by synchronization serial controller.
> 
> anybody can give me some ideas? 
> 
> and can i get the idea in this maillist??


Read the FAQ, at http://bridge.sourceforge.net
Most wireless devices, won't work as bridges because they can't send with different
Ethernet source address.  Also, devices that don't use Ethernet framing (like Irda, PPP)
will not work in a bridge.
