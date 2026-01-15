<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<meta charset="UTF-8">

<h2>문의</h2>

<div id="inquiryApp">
  <table>
    <tr>
      <th>회원수</th>
      <th>문의</th>
    </tr>
    <!-- <tr>
      <td>{{ memberCnt }}</td>
      <td>{{ reportCnt }}</td>
    </tr> -->
  </table>
  <div>
    inquiry
  </div>
</div>

<script>
const inquiryApp = Vue.createApp({
  data() {
    return {
      memberCnt: 0,
      reportCnt: 0
    };
  },
  methods: {
    // async loadDashboard() {
    //   try {
    //     const response = await fetch('/admin/dashboard/data.do');

    //     if (!response.ok) {
    //       throw new Error('서버 응답 오류');
    //     }

    //     const data = await response.json();

    //     console.log(data);
    //     this.memberCnt = data.memberCnt;
    //     this.reportCnt = data.reportCnt;

    //   } catch (error) {
    //     console.error('대시보드 데이터 조회 실패', error);
    //   }
    // }
  },
  mounted() {
    // this.loadDashboard();
  }
});

inquiryApp.mount('#inquiryApp');
</script>
