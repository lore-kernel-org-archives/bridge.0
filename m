Message-ID: <41C15C9D.50102@belkam.com>
Date: Thu, 16 Dec 2004 13:59:57 +0400
From: Dmitry Melekhov <dm@belkam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Bridge] 2.4.28 oops
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

Hello!

I don't shure I'm writing to right list, please point me to right list, 
if this is wrong place.
And I posted this message to linux-net... Sorry!

I run Linux as bridge (with ebtables), router and ipsec using 
super-freeswan/openswan.

ipsec interface is over br interface, there are also vlan interfaces on 
the same eth interfaces wich are in bridge.

Kernel 2.4.20 works OK, but I have kernel crash when I try to use htb 
qos over ipsec interfaces.

So I decided to move to newer kernel.

This is 2.4.28 from kernel org with openswan 1.0.8 and 
ebtables-brnf-8_vs_2.4.28. 
<http://prdownloads.sourceforge.net/ebtables/ebtables-brnf-8_vs_2.4.28.diff.gz?download> 


Here is kernel oops:

vpn_22_203 login: Unable to handle kernel NULL pointer dereference at 
virtual address 00000024
d0129426
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<d0129426>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: c02efb50   ecx: c02efb50   edx: cde528e0
esi: 00000000   edi: d00c7be0   ebp: d00c7be0   esp: c02efad8
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c02ef000)
Stack: c02efb30 80000000 c0347560 c0211648 00000004 c02efb50 00000000 
ce314804
      d00c7be0 80000000 00000004 ce314804 00000000 c0211955 c0347560 
c02efb50
      00000004 00000000 ce314804 c02efb30 d00c7be0 80000000 d012ecf0 
cdb3a9e0
Call Trace:    [<c0211648>] [<d00c7be0>] [<c0211955>] [<d00c7be0>] 
[<d012ecf0>]
 [<d00cbade>] [<d00c7be0>] [<d00c7be0>] [<c0211648>] [<d00c7be0>] 
[<c0211955>]
 [<d00c7be0>] [<d00cdb00>] [<d00c7cea>] [<d00c7be0>] [<c0211995>] 
[<d00c7cb0>]
 [<d00cb899>] [<d00c7cb0>] [<d00c7cb0>] [<c0211648>] [<d00c7cb0>] 
[<c0211955>]
 [<d00c7cb0>] [<d00cdae8>] [<d00c7d2a>] [<d00c7cb0>] [<d00c7273>] 
[<d00c72af>]
 [<c0209682>] [<c022279c>] [<c0222710>] [<d00cbc2d>] [<c0222710>] 
[<c0211648>]
 [<c0222710>] [<c0211955>] [<c0222710>] [<d00cdba8>] [<c021fa90>] 
[<c0220f2a>]
 [<c0222710>] [<c021fa90>] [<c021fac6>] [<d00cbc2d>] [<c021fa90>] 
[<c0211648>]
 [<d010be20>] [<c021fa90>] [<c0211955>] [<d010be20>] [<c021fa90>] 
[<d00cdb48>]
 [<d010be20>] [<c021fa05>] [<d010be20>] [<c021fa90>] [<d010be20>] 
[<c021ea47>]
 [<c021e880>] [<d00cbb85>] [<c0211648>] [<d010be20>] [<c021e880>] 
[<c0211955>]
 [<d010be20>] [<c021e880>] [<d00cdb18>] [<c021e68c>] [<d010be20>] 
[<c021e880>]
 [<d010be20>] [<c0209c6c>] [<d010be20>] [<d010be20>] [<c0209d80>] 
[<c0209e9f>]
 [<c011af39>] [<c010a081>] [<c0106ea0>] [<c010c3b8>] [<c0106ea0>] 
[<c0106ec4>]
 [<c0106f32>] [<c0105000>]
Code: 8b 46 24 39 42 60 77 07 ba 01 00 00 00 eb e9 57 52 e8 f4 8c

 >>EIP; d0129426 <[ip_conntrack].text.start+3c6/34af>   <=====

 >>ebx; c02efb50 <init_task_union+1b50/c749>
 >>ecx; c02efb50 <init_task_union+1b50/c749>
 >>edx; cde528e0 <_end+db0781c/fcc7fec>
 >>edi; d00c7be0 <[bridge].text.start+b80/4dbb>
 >>ebp; d00c7be0 <[bridge].text.start+b80/4dbb>
 >>esp; c02efad8 <init_task_union+1ad8/c749>

Trace; c0211648 <nf_getsockopt+88/c0>
Trace; d00c7be0 <[bridge].text.start+b80/4dbb>
Trace; c0211955 <nf_hook_slow+65/150>
Trace; d00c7be0 <[bridge].text.start+b80/4dbb>
Trace; d012ecf0 <[ip_conntrack].data.start+30/893>
Trace; d00cbade <[bridge].text.start+4a7e/4dbb>
Trace; d00c7be0 <[bridge].text.start+b80/4dbb>
Trace; d00c7be0 <[bridge].text.start+b80/4dbb>
Trace; c0211648 <nf_getsockopt+88/c0>
Trace; d00c7be0 <[bridge].text.start+b80/4dbb>
Trace; c0211955 <nf_hook_slow+65/150>
Trace; d00c7be0 <[bridge].text.start+b80/4dbb>
Trace; d00cdb00 <[bridge].data.start+2e0/557>
Trace; d00c7cea <[bridge].text.start+c8a/4dbb>
Trace; d00c7be0 <[bridge].text.start+b80/4dbb>
Trace; c0211995 <nf_hook_slow+a5/150>
Trace; d00c7cb0 <[bridge].text.start+c50/4dbb>
Trace; d00cb899 <[bridge].text.start+4839/4dbb>
Trace; d00c7cb0 <[bridge].text.start+c50/4dbb>
Trace; d00c7cb0 <[bridge].text.start+c50/4dbb>
Trace; c0211648 <nf_getsockopt+88/c0>
Trace; d00c7cb0 <[bridge].text.start+c50/4dbb>
Trace; c0211955 <nf_hook_slow+65/150>
Trace; d00c7cb0 <[bridge].text.start+c50/4dbb>
Trace; d00cdae8 <[bridge].data.start+2c8/557>
Trace; d00c7d2a <[bridge].text.start+cca/4dbb>
Trace; d00c7cb0 <[bridge].text.start+c50/4dbb>
Trace; d00c7273 <[bridge].text.start+213/4dbb>
Trace; d00c72af <[bridge].text.start+24f/4dbb>
Trace; c0209682 <dev_queue_xmit+a2/2d0>
Trace; c022279c <ip_send_check+ec/500>
Trace; c0222710 <ip_send_check+60/500>
Trace; d00cbc2d <[bridge].text.start+4bcd/4dbb>
Trace; c0222710 <ip_send_check+60/500>
Trace; c0211648 <nf_getsockopt+88/c0>
Trace; c0222710 <ip_send_check+60/500>
Trace; c0211955 <nf_hook_slow+65/150>
Trace; c0222710 <ip_send_check+60/500>
Trace; d00cdba8 <[bridge].data.start+388/557>
Trace; c021fa90 <ipfrag_flush+270/8c0>
Trace; c0220f2a <ip_finish_output+11a/4f0>
Trace; c0222710 <ip_send_check+60/500>
Trace; c021fa90 <ipfrag_flush+270/8c0>
Trace; c021fac6 <ipfrag_flush+2a6/8c0>
Trace; d00cbc2d <[bridge].text.start+4bcd/4dbb>
Trace; c021fa90 <ipfrag_flush+270/8c0>
Trace; c0211648 <nf_getsockopt+88/c0>
Trace; d010be20 <[ipsec]ipsec_alg_test+27ab0/2bcf0>
Trace; c021fa90 <ipfrag_flush+270/8c0>
Trace; c0211955 <nf_hook_slow+65/150>
Trace; d010be20 <[ipsec]ipsec_alg_test+27ab0/2bcf0>
Trace; c021fa90 <ipfrag_flush+270/8c0>
Trace; d00cdb48 <[bridge].data.start+328/557>
Trace; d010be20 <[ipsec]ipsec_alg_test+27ab0/2bcf0>
Trace; c021fa05 <ipfrag_flush+1e5/8c0>
Trace; d010be20 <[ipsec]ipsec_alg_test+27ab0/2bcf0>
Trace; c021fa90 <ipfrag_flush+270/8c0>
Trace; d010be20 <[ipsec]ipsec_alg_test+27ab0/2bcf0>
Trace; c021ea47 <ip_rcv+747/1370>
Trace; c021e880 <ip_rcv+580/1370>
Trace; d00cbb85 <[bridge].text.start+4b25/4dbb>
Trace; c0211648 <nf_getsockopt+88/c0>
Trace; d010be20 <[ipsec]ipsec_alg_test+27ab0/2bcf0>
Trace; c021e880 <ip_rcv+580/1370>
Trace; c0211955 <nf_hook_slow+65/150>
Trace; d010be20 <[ipsec]ipsec_alg_test+27ab0/2bcf0>
Trace; c021e880 <ip_rcv+580/1370>
Trace; d00cdb18 <[bridge].data.start+2f8/557>
Trace; c021e68c <ip_rcv+38c/1370>
Trace; d010be20 <[ipsec]ipsec_alg_test+27ab0/2bcf0>
Trace; c021e880 <ip_rcv+580/1370>
Trace; d010be20 <[ipsec]ipsec_alg_test+27ab0/2bcf0>
Trace; c0209c6c <netif_receive_skb+fc/3d0>
Trace; d010be20 <[ipsec]ipsec_alg_test+27ab0/2bcf0>
Trace; d010be20 <[ipsec]ipsec_alg_test+27ab0/2bcf0>
Trace; c0209d80 <netif_receive_skb+210/3d0>
Trace; c0209e9f <netif_receive_skb+32f/3d0>
Trace; c011af39 <do_softirq+99/a0>
Trace; c010a081 <enable_irq+121/130>
Trace; c0106ea0 <default_idle+0/b0>
Trace; c010c3b8 <disable_irq_nosync+1d78/2b80>
Trace; c0106ea0 <default_idle+0/b0>
Trace; c0106ec4 <default_idle+24/b0>
Trace; c0106f32 <default_idle+92/b0>
Trace; c0105000 <empty_zero_page+1000/2e80>

<0>Kernel panic: Aiee, killing interrupt handler!


btw, kernel 2.4.26 dies with almost the same results (unfortunately, I 
didn't wrote oops).

Could you look to this and give me an idea where is problem? I.e. this 
is bridge or ipsec problem or something else?

Thank you!

