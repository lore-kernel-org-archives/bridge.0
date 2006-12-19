Date: Mon, 18 Dec 2006 18:18:25 -0800 (PST)
From: hong zhang <henryzhang@arrowspan.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-261723958-1166494705=:21181"
Message-ID: <420859.21181.qm@web815.biz.mail.mud.yahoo.com>
Subject: [Bridge] entery deleted in forward table and no longer added
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

This is a multi-part message in MIME format...

--0-261723958-1166494705=:21181
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

Folks,
   
  I tried to create a forward table on GW2348 (avila) board. Dummy network interface is created to simulate sending traffics to kernel from virtual remote port with mac addresses every 5 seconds. It works perfectly in fedora 5 that means "brctl showmacs br0" returns remote mac address on table all the time.
   
  But in GW2348 board, remote mac entry only shows before forwarding timer expired. After that no more remote entries show up after "brctl showmacs br0".
   
  Anyone knows why? 
   
  ---henry

--0-261723958-1166494705=:21181
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

<div>Folks,</div>  <div>&nbsp;</div>  <div>I tried to create a forward table on GW2348 (avila) board. Dummy network interface is created to&nbsp;simulate sending traffics to kernel from virtual remote port with mac addresses every 5 seconds. It works perfectly in fedora 5 that means "brctl showmacs br0" returns remote mac address on table all the time.</div>  <div>&nbsp;</div>  <div>But in GW2348 board, remote mac entry only shows before forwarding timer expired. After that no more remote entries show up after "brctl showmacs br0".</div>  <div>&nbsp;</div>  <div>Anyone knows why? </div>  <div>&nbsp;</div>  <div>---henry</div>
--0-261723958-1166494705=:21181--
