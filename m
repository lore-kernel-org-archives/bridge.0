Message-ID: <4DF6D276.7000804@cn.fujitsu.com>
Date: Tue, 14 Jun 2011 11:16:06 +0800
From: Shan Wei <shanwei@cn.fujitsu.com>
MIME-Version: 1.0
References: <bug-37202-10286@https.bugzilla.kernel.org/>
	<20110613163735.34c42044.akpm@linux-foundation.org>
In-Reply-To: <20110613163735.34c42044.akpm@linux-foundation.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Bridge] [Bugme-new] [Bug 37202] New: Cannot change MTU on
	bridged interface
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, bugme-daemon@bugzilla.kernel.org, holler@ahsoftware.de, steve-alexander@roadrunner.com

Andrew Morton wrote, at 06/14/2011 07:37 AM:
> 
> (switched to email.  Please respond via emailed reply-to-all, not via the
> bugzilla web interface).
> 
> On Sat, 11 Jun 2011 10:59:18 GMT
> bugzilla-daemon@bugzilla.kernel.org wrote:
> 
>> https://bugzilla.kernel.org/show_bug.cgi?id=37202
>>
>>            Summary: Cannot change MTU on bridged interface
>>            Product: Networking
>>            Version: 2.5
>>     Kernel Version: 3.0.0-rc2
>>           Platform: All
>>         OS/Version: Linux
>>               Tree: Mainline
>>             Status: NEW
>>           Severity: normal
>>           Priority: P1
>>          Component: Other
>>         AssignedTo: acme@ghostprotocols.net
>>         ReportedBy: steve-alexander@roadrunner.com
>>         Regression: No
>>
>>
>> Without bridge, setting mtu on eth0 works as expected.
>> When eth0 is added to bridge 'br0' and this command is executed,
>>
>> ip link set eth0 mtu 4000

This bug has been fixed.

commit 6407d74c5106bb362b4087693688afd34942b094
Author: Alexander Holler <holler@ahsoftware.de>
Date:   Tue Jun 7 00:51:35 2011 -0700

    bridge: provide a cow_metrics method for fake_ops
    
    Like in commit 0972ddb237 (provide cow_metrics() methods to blackhole
    dst_ops), we must provide a cow_metrics for bridges fake_dst_ops as
    well.
    
    This fixes a regression coming from commits 62fa8a846d7d (net: Implement
    read-only protection and COW'ing of metrics.) and 33eb9873a28 (bridge:
    initialize fake_rtable metrics)
    
    ip link set mybridge mtu 1234

-- 
Best Regards
-----
Shan Wei
