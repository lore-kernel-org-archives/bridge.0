Message-ID: <40342BA6.9020505@cox.net>
Date: Wed, 18 Feb 2004 20:21:10 -0700
From: Greg Morgan <drkludge@cox.net>
MIME-Version: 1.0
Subject: Re: [Bridge] Fedora 2.4.22-1.2166.nptl
References: <002101c3f5c2$cdd191b0$1910a8c0@Christy>
In-Reply-To: <002101c3f5c2$cdd191b0$1910a8c0@Christy>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: AJM <ameader@corp.lcom.net>
Cc: bridge@osdl.org

AJM wrote:
> Hi,
> 
> I'm having trouble applying ebtables-brnf-3_vs_2.4.22.diff to
> 2.4.22-1.2166.nptl. Applying the patch did not go well. Can anyone help me
> with this? TIA.
> 
> Andy
I think you are running into Red Hat's backporting feature.  Please read 
http://www.redhat.com/advice/speaks_backport.html.  The key point is 
this "We can't please everyone, and backporting annoys some users who 
always want to be upgraded to the latest and greatest releases. However, 
in general, customers are more interested in stability, and the ability 
to minimise the changes needed for their QA and deployment.

A patch is made for a specific kernel set of sources.  Red Hat Fedora 
has applied various patchs in an order that the ebtables patch was not 
designed for.  The patch may or may not have worked on an earlier 
kernel.  FC1 just released a security fix today so the current kernel 
rpm is kernel-2.4.22-1.2174...

Fedora is all about community involvement 
http://fedora.redhat.com/participate/.  They would like you to raise 
bugzilla bugs to ask for new features.  Why don't you raise a bug so 
that your desire to have ebtables-brnf-3_vs_2.4.22 patch in the 2.4 
kernels series is made known?  However, FC2 test 1 is available with the 
2.6 kernel 
http://download.fedora.redhat.com/pub/fedora/linux/core/test/1.90/i386/. 
  This release may still not have the ebtables code that you are looking 
for.

I hope this helps.  I had a similar experience with LIS streams and Red 
Hat 7.3.  After the second kernel rpm, the LIS patch no longer compiled.

Regards,
Greg Morgan

