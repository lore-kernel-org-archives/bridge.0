MIME-Version: 1.0
Date: Wed, 7 Apr 2010 15:34:08 +0530
Message-ID: <r2ocfeab66d1004070304w85b4c592h59dd01fa344d9fbc@mail.gmail.com>
From: ratheesh k <ratheesh.ksz@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bridge] queing layer and bridge traffic .
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Hi ,

I know that netif_receive_skb()  and dev_queue_xmit()  are enty and
exit function queing layer of linux ip stack . I believe these
functions are called only for ip packets ( not for frames ) . Am i
right here ?

My question : Whether these functions are invloved in any brigde
function ( frames ) ?


Thanks,
Ratheesh
