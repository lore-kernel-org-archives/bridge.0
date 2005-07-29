Date: Thu, 28 Jul 2005 21:33:02 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] mac table updates
Message-ID: <20050728213302.18c9fd06@localhost.localdomain>
In-Reply-To: <42E968FF.6000607@metaloft.com>
References: <42E968FF.6000607@metaloft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Dirk Morris <dmorris@metaloft.com>
Cc: bridge@lists.osdl.org

On Thu, 28 Jul 2005 16:23:43 -0700
Dirk Morris <dmorris@metaloft.com> wrote:

> I think the new mac ageing (sometime since 2.6.8.1) may be too
> aggressive. Now it updates the table at a much later time, with a
> comment in the code that leads me to believe
> this is to prevent counting spoofed packets and a DOS.
> 
> My problem is that the update occurs after the netfilter hooks which
> may do weird things to change the course of the packet so that it
> does not get counted.
> (in my case, redirecting, queueing to userspace, nonlocally bound 
> sockets, etc).
> For me this causes packets to go spewing out on the wrong interface
> when the timer expires.
> 
> I used the attached patch to revert back to the old method.
> 
> -Dirk

If you are whacking the source address, that seems wrong.  The fix for
that would be to copy the original source address somewhere, then
extract it back afterwards.
