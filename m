Date: Thu, 28 May 2009 10:39:13 -0700
From: Stephen Hemminger <shemminger@vyatta.com>
Message-ID: <20090528103913.5b06cd42@nehalam>
In-Reply-To: <849c76670905271847ta7bc2a8s4464547125f79028@mail.gmail.com>
References: <849c76670905271049w76813768v8bce6aed46806c06@mail.gmail.com>
	<849c76670905271842y4efc0ed8sbbd047ac27572945@mail.gmail.com>
	<849c76670905271847ta7bc2a8s4464547125f79028@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Help Needed On Ethernet Bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Thinkstor Inc <thinkstor@gmail.com>
Cc: bridge@linux-foundation.org

On Thu, 28 May 2009 07:17:29 +0530
Thinkstor Inc <thinkstor@gmail.com> wrote:

>    Hi All,
>            My requirement is as below,
> 
> * I have to create a bridge on linux machine (kernel 2.6.23) and it has 2
> interfaces(eth0 & eth1)
> * I should have the control of Port State Changes
> (LISTENING,LEARNING,BLOCKING,FORWARDING,DISABLED) and
>    Only BLOCKING & FORWARDING States I Wud Be Using. I have to ensure that
> the port state never goes to any other states other than BLOCKING &
> FORWARDING.
> * Other thing is I have to send the control packets using the llc API's &
> NF_HOOK On both the interfaces and I recieve on LLC_SAP_BSPAN (Service
> Access Point Of STP)
> 
> The Messages I Send Wud be Control Packets Which Have To Pass Through Even
> If Port State Is BLOCKING...
> 
> I Have to form a ring like this
> 
>           NODE 1                NODE 2                NODE 3
>  -->eth1        eth0<----->eth1     eth0 <----->eth1      eth0<--
>  |--------------------------------------------------------------|
> 
> 
> What I have done So far is
>  * I have commented the STP port state change code So that Port wont
> traverse to any other state.
>  * I have IOCTL's to Send My Message And I Use LLC API's& NF_HOOK Which STP
> Uses to achieve sending.
>  * Recv Part I Do It On STP's stp_bpdu_rcv().
> 
> Everything Works Fine But Sometimes It Crashes...
> I'm not getting where exactly its breaking Can u please help me with this
> regard.

This looks a lot like the user level RSTP daemon. See:
 git://git.kernel.org/pub/scm/linux/kernel/git/shemminger/rstp.git

-- 
