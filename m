Message-Id: <6.1.2.0.2.20050531103813.03ffb590@luna.tlmat.unican.es>
Date: Tue, 31 May 2005 10:45:28 +0200
From: Jorge Lanza <jlanza@tlmat.unican.es>
In-Reply-To: <1117523207.32760.84.camel@buttercup>
References: <5.2.0.9.1.20050530155338.024bd488@mailhost.csse.uwa.edu.au>
	<1117523207.32760.84.camel@buttercup>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Subject: [Bridge] Source code bug or doubt - Not freeing port struct
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

Hi all.

During the last few days I've been going through the code in order to 
understand how can I hack it to make the things I want to a packet on layer 2.
First of all, congratulations. I have learnt a lot.

However I have a doubt. In n<http://lxr.linux.no/ident?i=new_nbp>ew_nbp() 
funtion in br_if.c you make a kalloc for the port. While reading the code I 
haven't seen any kfree for that memory, which should be done in 
<http://lxr.linux.no/ident?i=del_nbp>del_nbp or similar functions. In 
<http://lxr.linux.no/ident?i=destroy_nbp>destroy_nbp you set the pointer to 
null, but I think that's not enough. I don't know if it is a bug or is sth 
that is done somewhere else.

I would appreciate if you can give me some hint on that.
TA.


