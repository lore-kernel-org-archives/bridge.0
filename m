Message-ID: <419E0362.7030400@core.gen.tr>
Date: Fri, 19 Nov 2004 16:29:54 +0200
From: Aycan iRiCAN <aycan@core.gen.tr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Bridge] brctl returns 0 on error
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@osdl.org

Hi,

"brctl" returns 0 when trying to delete non-existent bridge. If it 
returns 0, scripting will be an headache. It should return different than 0.

# brctl delbr geek
bridge geek doesn't exist; can't delete it
# echo $?
0

Thanks.

-- 
Aycan iRiCAN
Core Computer Security Group
http://www.core.gen.tr

