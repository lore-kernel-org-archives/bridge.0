Message-ID: <88240e94040927191716269955@mail.gmail.com>
Date: Mon, 27 Sep 2004 19:17:21 -0700
From: TEJAS VORA <voratejas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] FTP and HTTP Passing over bridge
Reply-To: TEJAS VORA <voratejas@gmail.com>
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@osdl.org

Hi All,

We are developing a Gateway product which sits between Content Server
(provides FTP, HTTP and HTTPS service).
The main functionality of the gateway is to provide faster data
transfer over TCP in Wireless Networks. For this we have changed the
kernel and
it is working fine.

For all opther protocols to pass through normally - we have installed
the Bridge Mode service on the gateway. But gateway silently pass
through data -
so any TCP packet passing through gateway DOES NOT GO UP TO TCP Layer
in TCP / IP stack.

To solve this problem - we are using jftpgw (FTP proxy) and Squid
(HTTP Proxy) so that FTP and HTTP packets go up to TCP layer in TCP/IP
Stack.

Our main needs are

1. Machine performace should not get affected
2. FTP, HTTP and HTTPS packet should go through TCP layer rather
silently pass through by Bridge Mode
3. The source IP address should not be changed while connecting to
content Server - Becuase Content Server is using IP Authentication
   (as SQUID Does)
4. FTP Data Source port (port 20) should not get changed while sending
data back to Client

Now questions are

1. Is this solution - using proxy - is appropriate or is there any
alternate solution?
2. Are this tools efficient and do they effect the Machine performance
in terms of CPU and Memory Utilization - if not which is best
3. If not then is there any COMMERCIAL proxy software available to
achieve this desired functionality
4. What is the solution for HTTPS?
5. Squid changes the Source IP address while connecting to Content
Server - we do not want this - as server is using IP Authentication -
what is the solution for this

Looking for a help.

Thanks,
Tejas
