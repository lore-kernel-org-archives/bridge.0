Date: Mon, 31 Oct 2005 10:51:20 -0800
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] device eth0 is already a member of a bridge;
	can'tenslave it to bridge Net6
Message-ID: <20051031105120.103dd809@dxpl.pdx.osdl.net>
In-Reply-To: <003c01c5de4a$ee95fb80$6502a8c0@tim>
References: <001701c5de02$7f634440$6502a8c0@tim>
	<20051031094106.7294520d@dxpl.pdx.osdl.net>
	<003c01c5de4a$ee95fb80$6502a8c0@tim>
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
To: Tim Keupen <timbub@uni-koblenz.de>
Cc: bridge@lists.osdl.org

On Mon, 31 Oct 2005 19:43:01 +0100
"Tim Keupen" <timbub@uni-koblenz.de> wrote:

> > Have you looked at umlsim
> no, problem has to be solved with vnuml
> 
>    >> Is this a bug or a feature? Why is it not allowed to bind an Interface 
> to two different bridges?
>    >> Is there a workaround for this issue?
> > There was no good reason to allow it, I guess. Also, I would worry about 
> > races on deleting
> > a bridge and the RCU issues.
> But what should be a reasen not to allow it?

Because it the input path hook how bridge's get data would
cause increased stack depth (if it even worked).

> What du you mean with races and RCU issues?
Look at how interfaces are removed from bridges, and the
code that notifies a bridge about interface changes. It would
probably break as well.


-- 
Stephen Hemminger <shemminger@osdl.org>
OSDL http://developer.osdl.org/~shemminger
