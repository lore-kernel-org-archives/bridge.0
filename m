Message-ID: <463B9B514A01D6119A0400A0C9B761A382CA76@postkontor.tekblad.no>
From: Kjetil Lund <kjetil.lund@tekblad.no>
Subject: RE: [Bridge] bridge at start up
Date: Fri, 28 Jan 2005 19:53:47 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: 'Dominic Anyanna ' <dominic@afrione.net>, "'bridge@lists.osdl.org '" <bridge@lists.osdl.org>

Create a simple startup-script in init.d, as described here for example:
http://commmunity.linux.com/howtos/Bridge+Firewall+DSL-3.shtml


--
Regards
K. Lund

-----Original Message-----
From: Dominic Anyanna
To: bridge@lists.osdl.org
Sent: 28.01.2005 18:55
Subject: [Bridge] bridge at start up


hi i have gone through the achieves but still could not get my bridge to
suvive a reboot .
please can anyone help me am using fedora core 2


-----Original message-----
From: bridge-request@lists.osdl.org
Date: Fri, 28 Jan 2005 03:08:06 +0100
To: bridge@lists.osdl.org
Subject: Bridge Digest, Vol 17, Issue 25

>  Send Bridge mailing list submissions to
>  	bridge@lists.osdl.org
>  
>  To subscribe or unsubscribe via the World Wide Web, visit
>  	http://lists.osdl.org/mailman/listinfo/bridge
>  or, via email, send a message with subject or body 'help' to
>  	bridge-request@lists.osdl.org
>  
>  You can reach the person managing the list at
>  	bridge-owner@lists.osdl.org
>  
>  When replying, please edit your Subject line so it is more specific
>  than "Re: Contents of Bridge digest..."
>  
>  
>  Today's Topics:
>  
>     1. Re: [PATCH/RFC] Reduce call chain length in netfilter
>        (Bart De Schuymer)
>     2. Re: [PATCH/RFC] Reduce call chain length in netfilter
>        (Patrick McHardy)
>     3. Re: [PATCH/RFC] Reduce call chain length in netfilter
>        (David S. Miller)
>     4. Re: [PATCH/RFC] Reduce call chain length in netfilter
>        (Patrick McHardy)
>     5. Re: [PATCH/RFC] Reduce call chain length in netfilter
>        (David S. Miller)
>     6. Re: [PATCH/RFC] Reduce call chain length in netfilter
>        (Patrick McHardy)
>     7. Re: [PATCH/RFC] Reduce call chain length in netfilter
>        (Rusty Russell)
>     8. Re: [PATCH/RFC] Reduce call chain length in netfilter
>        (Rusty Russell)
>  
>  
>
----------------------------------------------------------------------
>  
>  Message: 1
>  Date: Thu, 27 Jan 2005 22:16:04 +0100
>  From: Bart De Schuymer <bdschuym@pandora.be>
>  Subject: [Bridge] Re: [PATCH/RFC] Reduce call chain length in
>  	netfilter
>  To: "David S. Miller" <davem@davemloft.net>
>  Cc: netdev@oss.sgi.com, netfilter-devel@lists.netfilter.org,
>  	bridge@osdl.org,	snort2004@mail.ru,
gandalf@wlug.westbo.se,
>  	rusty@rustcorp.com.au,	dwmw2@infradead.org, ak@suse.de,
>  	shemminger@osdl.org
>  Message-ID: <1106860564.3389.4.camel@localhost.localdomain>
>  Content-Type: text/plain
>  
>  Op do, 27-01-2005 te 11:47 -0800, schreef David S. Miller:
>  > On Thu, 27 Jan 2005 18:50:50 +0100
>  > Patrick McHardy <kaber@trash.net> wrote:
>  > 
>  > >  From what I can see it doesn't generate tail-calls currently:
>  > 
>  > Indeed... It even doesn't do this on Sparc64 either, even for
>  > the okfn(skb) call which I was sure it would.
>  > 
>  > It won't tail-call for function pointers for some strance reason
>  > as exhibited by this simple test:
>  > 
>  > struct sk_buff {
>  > 	int foo;
>  > };
>  > 
>  > int invoke(struct sk_buff *skb, int (*okfn)(struct sk_buff *))
>  > {
>  > 	return okfn(skb);
>  > }
>  > 
>  > extern int test_func(struct sk_buff *);
>  > 
>  > int invoke2(struct sk_buff *skb)
>  > {
>  > 	return test_func(skb);
>  > }
>  > 
>  > In the generated asm on sparc64, invoke2() gets a tail-call
>  > whereas invoke() does not.  Hmmm...
>  
>  Pasha (<snort2004@mail.ru>) is currently using a bridge-nf patch vs
>  2.4.29 with the changes I sent to you. After two days he sent me
>  (yesterday) a message that all is well. Without the patch he was
getting
>  the stack overflow oopses.
>  
>  cheers,
>  Bart
>  
>  
>  
>  ------------------------------
>  
>  Message: 2
>  Date: Thu, 27 Jan 2005 23:48:04 +0100
>  From: Patrick McHardy <kaber@trash.net>
>  Subject: [Bridge] Re: [PATCH/RFC] Reduce call chain length in
>  	netfilter
>  To: "David S. Miller" <davem@davemloft.net>
>  Cc: netdev@oss.sgi.com, netfilter-devel@lists.netfilter.org,
>  	bdschuym@pandora.be, bridge@osdl.org, snort2004@mail.ru,
>  	rusty@rustcorp.com.au, dwmw2@infradead.org, ak@suse.de,
>  	shemminger@osdl.org, gandalf@wlug.westbo.se
>  Message-ID: <41F96FA4.4000105@trash.net>
>  Content-Type: text/plain; charset=ISO-8859-1; format=flowed
>  
>  David S. Miller wrote:
>  
>  >In the generated asm on sparc64, invoke2() gets a tail-call
>  >whereas invoke() does not.  Hmmm...
>  >
>  >
>  Apparently support for indirect tail-calls was added to gcc 3.4.
>  
>  gcc-3.3.5:
>  0x0000000000000000 <invoke+0>:  sub    $0x8,%rsp
>  0x0000000000000004 <invoke+4>:  callq  *%esi
>  0x0000000000000006 <invoke+6>:  add    $0x8,%rsp
>  0x000000000000000a <invoke+10>: retq  
>  
>  gcc-3.4.4:
>  0x0000000000000000 <invoke+0>:  mov    %rsi,%r11
>  0x0000000000000003 <invoke+3>:  jmpq   *%r11d
>  
>  Regards
>  Patrick
>  
>  
>  ------------------------------
>  
>  Message: 3
>  Date: Thu, 27 Jan 2005 15:24:50 -0800
>  From: "David S. Miller" <davem@davemloft.net>
>  Subject: [Bridge] Re: [PATCH/RFC] Reduce call chain length in
>  	netfilter
>  To: Patrick McHardy <kaber@trash.net>
>  Cc: netdev@oss.sgi.com, netfilter-devel@lists.netfilter.org,
>  	bdschuym@pandora.be, bridge@osdl.org, snort2004@mail.ru,
>  	rusty@rustcorp.com.au, dwmw2@infradead.org, ak@suse.de,
>  	shemminger@osdl.org, gandalf@wlug.westbo.se
>  Message-ID: <20050127152450.6daba4fa.davem@davemloft.net>
>  Content-Type: text/plain; charset=US-ASCII
>  
>  On Thu, 27 Jan 2005 23:48:04 +0100
>  Patrick McHardy <kaber@trash.net> wrote:
>  
>  > David S. Miller wrote:
>  > 
>  > >In the generated asm on sparc64, invoke2() gets a tail-call
>  > >whereas invoke() does not.  Hmmm...
>  >
>  > Apparently support for indirect tail-calls was added to gcc 3.4.
>  
>  Good data point.
>  
>  I've been trying to figure out ways to decrease the number of
>  args that get sent to nf_hook_slow but this would require
>  some API changes unfortunately.
>  
>  One idea goes like this, we create little descriptors of the form:
>  
>  struct nf_hook_desc {
>  	int (*okfn)(struct sk_buff *);
>  	int pf;
>  	int hook;
>  };
>  
>  Then NF_HOOK*() callsites do something like this:
>  
>  static const struct nf_hook_desc nf_ip_local_out = {
>  	.okfn = dst_output,
>  	.pf = PF_INET,
>  	.hook = NF_IP_LOCAL_OUT,
>  };
>  
>  ...
>  
>  	/* Send it out. */
>  	return NF_HOOK(&nf_ip_local_out, skb, NULL, rt->u.dst.dev);
>  
>  This gets us down to 4 arguments from 6.  I think we can kill
>  one more.
>  
>  It is never the case that both indev and outdev are both
>  set, so we can use some nf_hook_desc piece of state to
>  indicate which (in or out) the passed device pointer is.
>  
>  Oh yes, we can nicely add the thresh thing in here too
>  while we're at it.
>  
>  So the final nf_hook_desc might look something something like:
>  
>  struct nf_hook_desc {
>  	int (*okfn)(struct sk_buff *);
>  	int hook;
>  	int thresh;
>  	u8 pf; /* AF_MAX is 32 */
>  	u8 is_output;
>  };
>  
>  Hook could possibly use a smaller type as well to condense
>  the size of this thing even further.  I don't know if there
>  are any nice assumptions we can make about the hook numbers.
>  
>  Now, back to the compatability issue.  We could create a
>  new macro, NF_HOOK_DESC() and keep the existing ones around
>  via some nf_hook_slow() that basically does:
>  
>  int nf_hook_slow(int pf, unsigned int hook, struct sk_buff *skb,
>  		 struct net_device *indev, struct net_device *outdev,
>  		 int (*okfn)(struct sk_buff *), int thresh)
>  {
>  	struct nf_hook_desc desc;
>  
>  	desc.okfn = okfn;
>  	desc.hook = hook;
>  	desc.thresh = thresh;
>  	desc.pf = pf;
>  	desc.is_output = (outdev != NULL);
>  	return nf_hook_desc(&desc, skb, (outdev ? outdev : indev));
>  }
>  
>  So the final new stuff looks something like:
>  
>  #ifdef CONFIG_NETFILTER
>  struct nf_hook_desc {
>  	int (*okfn)(struct sk_buff *);
>  	int hook;
>  	int thresh;
>  	u8 pf; /* AF_MAX is 32 */
>  	u8 is_output;
>  };
>  #define NF_DESC_DECLARE(_name, _okfn, _hook, _thresh, _pf,
_is_output) \
>  static const struct nf_hook_desc _name = { \
>  	.okfn = _okfn, \
>  	.hook = _hook, \
>  	.thresh = _thresh, \
>  	.pf = _pf, \
>  	.is_output = _is_output, \
>  };
>  
>  extern int nf_hook_desc(struct nf_hook_desc *desc, struct sk_buff
*skb,
>  			struct net_device *dev);
>  
>  #define NF_HOOK_DESC(_desc, _skb, _dev) \
>  	nf_hook_desc(_desc, _skb, _dev)
>  #endif
>  
>  Just throwing around ideas... comments?
>  
>  ------------------------------
>  
>  Message: 4
>  Date: Fri, 28 Jan 2005 01:08:54 +0100
>  From: Patrick McHardy <kaber@trash.net>
>  Subject: [Bridge] Re: [PATCH/RFC] Reduce call chain length in
>  	netfilter
>  To: "David S. Miller" <davem@davemloft.net>
>  Cc: netdev@oss.sgi.com, netfilter-devel@lists.netfilter.org,
>  	bdschuym@pandora.be, bridge@osdl.org, snort2004@mail.ru,
>  	rusty@rustcorp.com.au, dwmw2@infradead.org, ak@suse.de,
>  	shemminger@osdl.org, gandalf@wlug.westbo.se
>  Message-ID: <41F98296.9040804@trash.net>
>  Content-Type: text/plain; charset=us-ascii; format=flowed
>  
>  David S. Miller wrote:
>  
>  >I've been trying to figure out ways to decrease the number of
>  >args that get sent to nf_hook_slow but this would require
>  >some API changes unfortunately.
>  >
>  >One idea goes like this, we create little descriptors of the form:
>  >
>  >struct nf_hook_desc {
>  >	int (*okfn)(struct sk_buff *);
>  >	int pf;
>  >	int hook;
>  >};
>  >
>  >Then NF_HOOK*() callsites do something like this:
>  >
>  >static const struct nf_hook_desc nf_ip_local_out = {
>  >	.okfn = dst_output,
>  >	.pf = PF_INET,
>  >	.hook = NF_IP_LOCAL_OUT,
>  >};
>  >
>  >...
>  >
>  >	/* Send it out. */
>  >	return NF_HOOK(&nf_ip_local_out, skb, NULL, rt->u.dst.dev);
>  >
>  >This gets us down to 4 arguments from 6.  I think we can kill
>  >one more.
>  >
>  >It is never the case that both indev and outdev are both
>  >set, so we can use some nf_hook_desc piece of state to
>  >indicate which (in or out) the passed device pointer is.
>  >  
>  >
>  indev and outdev are both set in the forward hook.
>  
>  >Oh yes, we can nicely add the thresh thing in here too
>  >while we're at it.
>  >
>  >So the final nf_hook_desc might look something something like:
>  >
>  >struct nf_hook_desc {
>  >	int (*okfn)(struct sk_buff *);
>  >	int hook;
>  >	int thresh;
>  >	u8 pf; /* AF_MAX is 32 */
>  >	u8 is_output;
>  >};
>  >
>  >Hook could possibly use a smaller type as well to condense
>  >the size of this thing even further.  I don't know if there
>  >are any nice assumptions we can make about the hook numbers.
>  >  
>  >
>  There are currently five hooks. I really hope we'll never reach
>  256, so u8 should be big enough.
>  
>  >Now, back to the compatability issue.  We could create a
>  >new macro, NF_HOOK_DESC() and keep the existing ones around
>  >via some nf_hook_slow() that basically does:
>  >
>  >int nf_hook_slow(int pf, unsigned int hook, struct sk_buff *skb,
>  >		 struct net_device *indev, struct net_device *outdev,
>  >		 int (*okfn)(struct sk_buff *), int thresh)
>  >{
>  >	struct nf_hook_desc desc;
>  >
>  >	desc.okfn = okfn;
>  >	desc.hook = hook;
>  >	desc.thresh = thresh;
>  >	desc.pf = pf;
>  >	desc.is_output = (outdev != NULL);
>  >	return nf_hook_desc(&desc, skb, (outdev ? outdev : indev));
>  >}
>  >
>  >So the final new stuff looks something like:
>  >
>  >#ifdef CONFIG_NETFILTER
>  >struct nf_hook_desc {
>  >	int (*okfn)(struct sk_buff *);
>  >	int hook;
>  >	int thresh;
>  >	u8 pf; /* AF_MAX is 32 */
>  >	u8 is_output;
>  >};
>  >#define NF_DESC_DECLARE(_name, _okfn, _hook, _thresh, _pf,
_is_output) \
>  >static const struct nf_hook_desc _name = { \
>  >	.okfn = _okfn, \
>  >	.hook = _hook, \
>  >	.thresh = _thresh, \
>  >	.pf = _pf, \
>  >	.is_output = _is_output, \
>  >};
>  >
>  >extern int nf_hook_desc(struct nf_hook_desc *desc, struct sk_buff
*skb,
>  >			struct net_device *dev);
>  >
>  >#define NF_HOOK_DESC(_desc, _skb, _dev) \
>  >	nf_hook_desc(_desc, _skb, _dev)
>  >#endif
>  >
>  >Just throwing around ideas... comments?
>  >  
>  >
>  Sounds like a good idea to get rid of the static arguments to
>  nf_hook_slow. Keeping both devices we are still down from 7 to
>  4 arguments with your suggestion.
>  
>  Regards
>  Patrick
>  
>  
>  ------------------------------
>  
>  Message: 5
>  Date: Thu, 27 Jan 2005 17:10:23 -0800
>  From: "David S. Miller" <davem@davemloft.net>
>  Subject: [Bridge] Re: [PATCH/RFC] Reduce call chain length in
>  	netfilter
>  To: Rusty Russell <rusty@rustcorp.com.au>
>  Cc: netdev@oss.sgi.com, bdschuym@pandora.be, bridge@osdl.org,
>  	snort2004@mail.ru,	gandalf@wlug.westbo.se,
>  	netfilter-devel@lists.netfilter.org,	dwmw2@infradead.org,
ak@suse.de,
>  	shemminger@osdl.org
>  Message-ID: <20050127171023.2e8547e1.davem@davemloft.net>
>  Content-Type: text/plain; charset=US-ASCII
>  
>  On Fri, 28 Jan 2005 11:29:29 +1100
>  Rusty Russell <rusty@rustcorp.com.au> wrote:
>  
>  > No, let's just fix them all.
>  
>  In tree, yes.  But leaving the NF_HOOK()/NF_HOOK_THRESH() compat
>  macros in there for out-of-tree modules I feel is mandatory, it's
>  a major API change.
>  
>  ------------------------------
>  
>  Message: 6
>  Date: Fri, 28 Jan 2005 02:35:42 +0100
>  From: Patrick McHardy <kaber@trash.net>
>  Subject: [Bridge] Re: [PATCH/RFC] Reduce call chain length in
>  	netfilter
>  To: Rusty Russell <rusty@rustcorp.com.au>
>  Cc: netdev@oss.sgi.com, bdschuym@pandora.be, bridge@osdl.org,
>  	snort2004@mail.ru,	gandalf@wlug.westbo.se, Netfilter
development
>  	mailing list	<netfilter-devel@lists.netfilter.org>,
>  	dwmw2@infradead.org,	ak@suse.de, shemminger@osdl.org, "David
S.
>  	Miller" <davem@davemloft.net>
>  Message-ID: <41F996EE.2030409@trash.net>
>  Content-Type: text/plain; charset=us-ascii; format=flowed
>  
>  Rusty Russell wrote:
>  
>  >On Thu, 2005-01-27 at 17:10 -0800, David S. Miller wrote:
>  >
>  >>In tree, yes.  But leaving the NF_HOOK()/NF_HOOK_THRESH() compat
>  >>macros in there for out-of-tree modules I feel is mandatory, it's
>  >>a major API change.
>  >>
>  >
>  >I'm not so sure.  The hook functions which are registered, sure (ie.
>  >keep the calling convention the same).  But do any external modules
use
>  >NF_HOOK()?  That implies they're writing their own network stack for
>  >some protocol, which I would expect to be uncommon.
>  >
>  Freeswan comes to mind. But I guess one more #ifdef can't hurt :)
>  
>  Regards
>  Patrick
>  
>  
>  ------------------------------
>  
>  Message: 7
>  Date: Fri, 28 Jan 2005 11:29:29 +1100
>  From: Rusty Russell <rusty@rustcorp.com.au>
>  Subject: [Bridge] Re: [PATCH/RFC] Reduce call chain length in
>  	netfilter
>  To: "David S. Miller" <davem@davemloft.net>
>  Cc: netdev@oss.sgi.com, bdschuym@pandora.be, bridge@osdl.org,
>  	snort2004@mail.ru,	gandalf@wlug.westbo.se, Netfilter
development
>  	mailing list	<netfilter-devel@lists.netfilter.org>,
>  	dwmw2@infradead.org,	ak@suse.de, shemminger@osdl.org
>  Message-ID: <1106872169.18360.6.camel@localhost.localdomain>
>  Content-Type: text/plain
>  
>  On Thu, 2005-01-27 at 15:24 -0800, David S. Miller wrote:
>  > It is never the case that both indev and outdev are both
>  > set, so we can use some nf_hook_desc piece of state to
>  > indicate which (in or out) the passed device pointer is.
>  
>  NF_IP_FORWARD... it's really *really* useful for filtering forwarded
>  packets.  However, is it ever the case that indev != skb->dev?  If
not,
>  we can simply drop that arg and use skb->dev.
>  
>  > Now, back to the compatability issue.  We could create a
>  > new macro, NF_HOOK_DESC() and keep the existing ones around
>  > via some nf_hook_slow() that basically does:
>  
>  No, let's just fix them all.  Also, gcc 3.4 will discard unused
static
>  variables, so I prefer the kernel start just declaring structs as
>  normal, and have them "used" in the !CONFIG case by an inline
function
>  which allows gcc to realize that it can be eliminated, but suppresses
>  unused warnings.  This also means you get type checking etc without
the
>  config option.
>  
>  BTW, someone should go through and start ripping out #ifdef
>  CONFIG_PROC_FS around those structs, too...
>  
>  Cheers,
>  Rusty.
>  -- 
>  A bad analogy is like a leaky screwdriver -- Richard Braakman
>  
>  
>  ------------------------------
>  
>  Message: 8
>  Date: Fri, 28 Jan 2005 12:32:25 +1100
>  From: Rusty Russell <rusty@rustcorp.com.au>
>  Subject: [Bridge] Re: [PATCH/RFC] Reduce call chain length in
>  	netfilter
>  To: "David S. Miller" <davem@davemloft.net>
>  Cc: netdev@oss.sgi.com, bdschuym@pandora.be, bridge@osdl.org,
>  	snort2004@mail.ru,	gandalf@wlug.westbo.se, Netfilter
development
>  	mailing list	<netfilter-devel@lists.netfilter.org>,
>  	dwmw2@infradead.org,	ak@suse.de, shemminger@osdl.org
>  Message-ID: <1106875946.18360.29.camel@localhost.localdomain>
>  Content-Type: text/plain
>  
>  On Thu, 2005-01-27 at 17:10 -0800, David S. Miller wrote:
>  > On Fri, 28 Jan 2005 11:29:29 +1100
>  > Rusty Russell <rusty@rustcorp.com.au> wrote:
>  > 
>  > > No, let's just fix them all.
>  > 
>  > In tree, yes.  But leaving the NF_HOOK()/NF_HOOK_THRESH() compat
>  > macros in there for out-of-tree modules I feel is mandatory, it's
>  > a major API change.
>  
>  I'm not so sure.  The hook functions which are registered, sure (ie.
>  keep the calling convention the same).  But do any external modules
use
>  NF_HOOK()?  That implies they're writing their own network stack for
>  some protocol, which I would expect to be uncommon.
>  
>  Rusty.
>  -- 
>  A bad analogy is like a leaky screwdriver -- Richard Braakman
>  
>  
>  ------------------------------
>  
>  _______________________________________________
>  Bridge mailing list
>  Bridge@lists.osdl.org
>  http://lists.osdl.org/mailman/listinfo/bridge
>  
>  
>  End of Bridge Digest, Vol 17, Issue 25
>  **************************************
>  





AfriOne Mail - AfriOne Cares!!!
 <<ATT01947.txt>> 
